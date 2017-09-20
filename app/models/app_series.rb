class AppSeries < ApplicationRecord
  has_many :apps
  has_one :accessibility
end
