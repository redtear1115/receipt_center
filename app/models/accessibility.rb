class Accessibility < ApplicationRecord
  include Unitable
  
  before_validation :verify_external_id!
  
  AVAILABLE_LIST = ['all', 'animation-desk', 'noteledge', 'pdf-series', 'write-on-video', 'pocket-scanner'].freeze
  
  private
  
  def verify_external_id!
    raise "#{self.external_id} not in #{available_list}" unless AVAILABLE_LIST.include?(self.external_id)
  end
end
