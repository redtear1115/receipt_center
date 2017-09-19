class PackItem < ApplicationRecord
  belongs_to :pack
  belongs_to :unit, polymorphic: true
end
