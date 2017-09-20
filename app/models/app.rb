class App < ApplicationRecord
  belongs_to :app_series
  has_many :packs
end
