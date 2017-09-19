class Pack < ApplicationRecord
  has_many :receipts
  has_many :items, class_name: 'PackItem'
end
