class Member < ApplicationRecord
  has_many :receipts
  has_many :credit_records

  def dashboard
    self.as_json(
      only: [:id],
      methods: [:credit_on_hand, :max_storage, :accessibility]
    )
  end
  
  def accessibility
    result = {}
    receipts = Receipt.valid.where(id: Accessibility.member_receipt_ids(self.id))
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
  
  def max_storage
    result = 0
    receipts = Receipt.valid.where(id: Storage.member_receipt_ids(self.id))
    receipts.each do |receipt|
      storage = receipt.pack.items.storage
      if receipt.pack.subscribable
        result += storage.capacity if receipt.valid_on?(Time.zone.now)
      else
        result += storage.capacity
      end
    end
    result
  end
  
  def credit_on_hand
    result = 0
    self.credit_records.occurred.each do |credit_record|
      if credit_record.increased?
        result += credit_record.amount
      elsif credit_record.decreased?
        result -= credit_record.amount
      end
    end
    result
  end
  
  def withdraw_credit(amount)
    return if credit_on_hand - amount < 0
    credit_records.create(movement: :withdraw, amount: amount, occurred_at: Time.zone.now)
    credit_records.occurred.will_expire.each do |credit_record|
      break if amount.zero?
      amount = credit_record.expire_record.comsume(amount)
    end
    credit_on_hand
  end
end
