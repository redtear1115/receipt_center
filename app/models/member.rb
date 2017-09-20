class Member < ApplicationRecord
  has_many :receipts

  def status
    self.as_json(
      methods: [:current_credits, :total_storage, :accessibility]
    )
  end
  
  def accessibility
    result = {}
    receipts = Receipt.where(id: Accessibility.member_receipt_ids(self.id))
    receipts.each do |receipt|
      acc = receipt.pack.items.accessibility
      # 保留最新的 valid_to
      if result[acc.external_id].nil?
        result[acc.external_id] = receipt.valid_to
      elsif receipt.valid_to > result[acc.external_id]
        result[acc.external_id] = receipt.valid_to
      end
    end
    result
  end
  
  def total_storage
    capacity = 0
    receipts = Receipt.where(id: Storage.member_receipt_ids(self.id))
    receipts.each do |receipt|
      storage = receipt.pack.items.storage
      if receipt.pack.subscribable
        capacity += storage.capacity if receipt.valid_on?(Time.zone.now)
      else
        capacity += storage.capacity
      end
    end
    capacity
  end
  
end
