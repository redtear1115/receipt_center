class PackItem < ApplicationRecord
  belongs_to :pack
  belongs_to :unit, polymorphic: true
  
  scope :storage, -> { find_by(unit_type: Storage.name).unit }
  scope :accessibility, -> { find_by(unit_type: Accessibility.name).unit }
  scope :credit, -> { find_by(unit_type: Credit.name).unit }
  scope :material, -> { find_by(unit_type: Material.name).unit }
end
