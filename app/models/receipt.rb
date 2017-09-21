class Receipt < ApplicationRecord
  belongs_to :member
  belongs_to :pack
  
  scope :valid, -> { where('valid_to > ? OR valid_to IS NULL', Time.zone.now) }
  
  before_validation :update_channel
  before_validation :update_valid_from_to
  after_create_commit :init_credit
  
  def pack_period
    pack.period_num.send("#{pack.period_unit}")
  end
  
  def valid_on?(datetime)
    self.valid_to >= datetime && self.valid_from <= datetime
  end
  
  def init_credit
    return if self.pack.items.credit.nil?
    credit = self.pack.items.credit
    if pack.subscribable?
      CreditRecord.create(member_id: self.member_id, movement: :deposit, amount: credit.amount, occurred_at: self.valid_from)
      CreditRecord.create(member_id: self.member_id, movement: :expired, amount: credit.amount, occurred_at: self.valid_to)
    else
      CreditRecord.create(member_id: self.member_id, movement: :deposit, amount: credit.amount, occurred_at: self.purchased_at)
    end
  end

  private
  
  def update_channel
    self.channel = self.pack.app.channel
  end
  
  def update_valid_from_to
    return unless pack.subscribable
    self.valid_from = self.purchased_at
    self.valid_to = self.valid_from + self.pack_period
    extend_valid_period
  end
  
  def extend_valid_period
    return unless pack.extendable
    while overlaps.any?
      self.valid_from = overlaps.last.valid_to 
      self.valid_to = self.valid_from + self.pack_period
    end
  end
  
  def overlaps
    receipts = Receipt.includes(:pack).valid.where(member_id: self.member_id).where("(valid_from, valid_to) OVERLAPS (?, ?)", self.valid_from, self.valid_to).order(:purchased_at)
    receipts.select{ |r| r.pack.extendable }
  end
end
