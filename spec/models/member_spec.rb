require 'rails_helper'

RSpec.describe Member, type: :model do
  before(:each) do
    # Create Member
    @member = create(:member)
    # Create Apps
    ad_ios_app = create(:ad_ios_app)
    nl_ios_app = create(:nl_ios_app)
    # Create Units
    all_acc = create(:all_acc)
    ad_acc = create(:ad_acc)
    nl_acc = create(:nl_acc)
    credit = create(:credit)
    storage = create(:storage)
    # Create deluxe pack
    @ad_ios_deluxe_pack = create(:ad_ios_deluxe_pack, app: ad_ios_app)
    create(:pack_item, pack: @ad_ios_deluxe_pack, unit: ad_acc)
    @nl_ios_deluxe_pack = create(:nl_ios_deluxe_pack, app: nl_ios_app)
    create(:pack_item, pack: @nl_ios_deluxe_pack, unit: nl_acc)
    # Create all access pack
    @ad_ios_pack = create(:ad_ios_pack, app: ad_ios_app)
    @nl_ios_pack = create(:nl_ios_pack, app: nl_ios_app)
    [all_acc, credit, storage].each do |unit|
       create(:pack_item, pack: @ad_ios_pack, unit: unit)
       create(:pack_item, pack: @nl_ios_pack, unit: unit)
    end
    # Create storage only pack
    @ad_ios_storage_10g = create(:ad_ios_storage_10g, app: ad_ios_app)
    create(:pack_item, pack: @ad_ios_storage_10g, unit: storage)
    # Create credit only pack
    @ad_ios_credit_20 = create(:ad_ios_credit_20, app: ad_ios_app)
    create(:pack_item, pack: @ad_ios_credit_20, unit: credit)
  end
  
  describe 'relationships' do
    it 'should be good' do
      receipt = create(:receipt, member: @member, pack: @ad_ios_pack)
      expect(@member.receipts.count).to eq(1)
      
      my_receipt = @member.receipts.first
      expect(my_receipt.channel).to eq(@ad_ios_pack.app.channel)
      expect(my_receipt.pack.items.count).to eq(3)
    end
  end
  
  describe '#accessibility' do
    it 'should return all/ad/nl and their valid_to' do
      all_receipt = create(:receipt, member: @member, pack: @ad_ios_pack)
      ad_receipt = create(:receipt, member: @member, pack: @ad_ios_deluxe_pack)
      nl_receipt = create(:receipt, member: @member, pack: @nl_ios_deluxe_pack)
    
      expect(@member.accessibility['all']).to eq(all_receipt.valid_to)
      expect(@member.accessibility['animation-desk']).to eq(ad_receipt.valid_to)
      expect(@member.accessibility['noteledge']).to eq(nl_receipt.valid_to)
    end
    
    it 'should auto extend and return new valid_to' do
      all_receipt1 = create(:receipt, member: @member, pack: @ad_ios_pack)
      ad_receipt = create(:receipt, member: @member, pack: @ad_ios_deluxe_pack)
      nl_receipt = create(:receipt, member: @member, pack: @nl_ios_deluxe_pack)
      all_receipt2 = create(:receipt, member: @member, pack: @nl_ios_pack)
      all_receipt3 = create(:receipt, member: @member, pack: @ad_ios_pack)
      
      expect(@member.accessibility['all']).to eq(all_receipt1.purchased_at + 3.month)
      expect(@member.accessibility['animation-desk']).to eq(ad_receipt.valid_to)
      expect(@member.accessibility['noteledge']).to eq(nl_receipt.valid_to)
    end
    
    it 'should return empty' do
      expect(@member.accessibility).to be_empty
    end
  end
  
  describe '#max_storage' do
    it 'should return infinity capacity + subscribed capacity' do
      all_receipt1 = create(:receipt, member: @member, pack: @ad_ios_pack)
      receipt = create(:receipt, member: @member, pack: @ad_ios_storage_10g)
      all_receipt2 = create(:receipt, member: @member, pack: @nl_ios_pack)
      all_receipt3 = create(:receipt, member: @member, pack: @ad_ios_pack)
      
      capacity = receipt.pack.items.storage.capacity + all_receipt1.pack.items.storage.capacity
      expect(@member.max_storage).to eq(capacity)
    end
    
    it 'should return 0' do
      expect(@member.max_storage).to eq(0)
    end
  end
  
  describe '#credit_on_hand' do
    it 'should return infinity credit + subscribed credit' do
      all_receipt1 = create(:receipt, member: @member, pack: @ad_ios_pack)
      receipt = create(:receipt, member: @member, pack: @ad_ios_credit_20)
      all_receipt2 = create(:receipt, member: @member, pack: @nl_ios_pack)
      all_receipt3 = create(:receipt, member: @member, pack: @ad_ios_pack)
      
      amount = receipt.pack.items.credit.amount + all_receipt1.pack.items.credit.amount
      expect(@member.credit_on_hand).to eq(amount)
    end
    
    it 'should return 0' do
      expect(@member.credit_on_hand).to eq(0)
    end
  end
  
  describe '#withdraw_credit' do
    it 'should return credit amount - withdraw amount' do
      receipt = create(:receipt, member: @member, pack: @ad_ios_credit_20)
      withdraw_amount = 6
      @member.withdraw_credit(withdraw_amount)
      amount = receipt.pack.items.credit.amount - withdraw_amount
      
      expect(@member.credit_on_hand).to eq(amount)
    end
  end
  
  describe '#dashboard' do
    it 'should return member dashboard' do
      all_receipt1 = create(:receipt, member: @member, pack: @ad_ios_pack)
      credit_receipt = create(:receipt, member: @member, pack: @ad_ios_credit_20)
      storage_receipt = create(:receipt, member: @member, pack: @ad_ios_storage_10g)
      all_receipt2 = create(:receipt, member: @member, pack: @nl_ios_pack)
      all_receipt3 = create(:receipt, member: @member, pack: @ad_ios_pack)
      
      expect(@member.dashboard['id']).to eq(@member.id)
      expect(@member.dashboard['credit_on_hand']).to eq(@member.credit_on_hand)
      expect(@member.dashboard['max_storage']).to eq(@member.max_storage)
      expect(@member.dashboard['accessibility']).to eq(@member.accessibility)
    end
  end
end
