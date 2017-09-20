require 'rails_helper'

RSpec.describe Member, type: :model do
  before(:each) do
    @member = create(:member)
    @accessibility = create(:accessibility)
    @credit = create(:credit)
    @storage = create(:storage)
    @app = create(:app)
    @pack = create(:pack, app: @app)
    @pack_item1 = create(:pack_item, pack: @pack, unit: @accessibility)
    @pack_item2 = create(:pack_item, pack: @pack, unit: @credit)
    @pack_item3 = create(:pack_item, pack: @pack, unit: @storage)
    @receipt = create(:receipt, member: @member, pack: @pack)
  end
  
  describe 'relationships' do
    it 'should be good' do
      expect(@member.receipts.count).to eq(1)
      
      my_receipt = @member.receipts.first
      expect(my_receipt.channel).to eq(@app.channel)
      expect(my_receipt.pack.items.count).to eq(3)
    end
  end
end
