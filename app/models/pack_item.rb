class PackItem < ApplicationRecord
  belongs_to :pack
  belongs_to :unit, polymorphic: true
  
  def self.storage
    item = find_by(unit_type: Storage.name)
    return if item.nil?
    item.unit
  end
  
  def self.accessibility
    item = find_by(unit_type: Accessibility.name)
    return if item.nil?
    item.unit
  end
  
  def self.credit 
    item = find_by(unit_type: Credit.name)
    return if item.nil?
    item.unit
  end
  
  def self.material
    item = find_by(unit_type: Material.name)
    return if item.nil?
    item.unit
  end
end
