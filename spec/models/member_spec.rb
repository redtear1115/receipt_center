require 'rails_helper'

RSpec.describe Member, type: :model do
  before(:each) do
    @member = create(:member)
    @accessibility = create(:accessibility)
    @credit = create(:credit)
    @storage = create(:storage)
    @pack = create(:pack)
    @pack_item1 = create(:pack_item, pack: @pack, unit: @accessibility)
    @pack_item2 = create(:pack_item, pack: @pack, unit: @credit)
    @pack_item3 = create(:pack_item, pack: @pack, unit: @storage)
    @receipt = create(:receipt, member: @member, pack: @pack)
  end
  
  describe 'relationships' do
    it 'should return one receipt' do
      binding.pry
      expect(@member.receipts.count).to eq(1)
    end
  end
end
