module Unitable
  extend ActiveSupport::Concern

  included do
    has_many :pack_items, as: :unit
  end
  
  module ClassMethods
    def member_receipt_ids(member_id)
      self.select('receipts.id')
        .joins(pack_items: { pack: :receipts })
        .where('receipts.member_id = ?', member_id)
        .pluck('receipts.id')
        .sort
        .uniq
    end
  end
end