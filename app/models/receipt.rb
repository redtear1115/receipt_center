class Receipt < ApplicationRecord
  belongs_to :member
  belongs_to :pack
end
