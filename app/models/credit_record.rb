class CreditRecord < ApplicationRecord
  belongs_to :member
  has_one :expire_record, class_name: 'CreditRecord', foreign_key: :expire_record_id
  
  enum movement: [:deposit, :withdraw, :expire]
  
  scope :occurred, -> { where('occurred_at <= ? ', Time.zone.now) }
  scope :will_expire, -> { where.not(expire_record_id: nil) }
  
  def increased?
    ['deposit'].include?(self.movement)
  end
  
  def decreased?
    ['withdraw', 'expired'].include?(self.movement)
  end
  
  def comsume(amount_to_comsume)
    if self.amount >= amount_to_comsume
      self.amount -= amount_to_comsume
      self.save!
      amount_to_comsume = 0
    else
      self.amount = 0
      self.save!
      amount_to_comsume -= self.amount
    end
    amount_to_comsume
  end
  
  def expire_record
    @expire_record ||= self.class.find_by(id: self.expire_record_id)
  end
end
