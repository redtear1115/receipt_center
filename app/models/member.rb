class Member < ApplicationRecord
  has_many :receipts

  def status
    self.as_json(
      methods: [:current_credits, :total_storage, :accessibility]
    )
  end
  
  def accessibility
  end
end
