class CreditRecord < ApplicationRecord
  belongs_to :member
  
  enum movement: [:deposit, :withdraw, :expired]
  
  scope :occurred, -> { where('occurred_at <= ? ', Time.zone.now) }
  
  def increased?
    ['deposit'].include?(self.movement)
  end
  
  def decreased?
    ['withdraw', 'expired'].include?(self.movement)
  end
end
