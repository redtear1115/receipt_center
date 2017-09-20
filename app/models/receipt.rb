class Receipt < ApplicationRecord
  belongs_to :member
  belongs_to :pack
  
  before_validation :update_channel
  
  def update_channel
    self.channel = self.pack.app.channel
  end
end
