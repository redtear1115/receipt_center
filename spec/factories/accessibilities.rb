FactoryGirl.define do
  factory :all_acc, class: Accessibility do
    external_id 'all'
  end
  
  factory :ad_acc, class: Accessibility do
    external_id 'animation-desk'
  end
  
  factory :nl_acc, class: Accessibility do
    external_id 'noteledge'
  end
end
