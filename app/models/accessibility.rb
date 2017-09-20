class Accessibility < ApplicationRecord
  belongs_to :app_series
  has_many :used_in, as: :unit
end
