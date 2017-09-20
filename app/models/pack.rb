class Pack < ApplicationRecord
  belongs_to :app
  has_many :receipts
  has_many :items, class_name: 'PackItem'
end
