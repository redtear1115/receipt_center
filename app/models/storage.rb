class Storage < ApplicationRecord
  has_many :used_in, as: :unit
end
