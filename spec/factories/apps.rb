FactoryGirl.define do
  factory :ad_ios_app, class: App do
    channel 'apple'
    os 'iOS'
    device 'iPhone'
    name 'Animation Desk Cloud iOS iPhone'
    external_id 'com.kdanmobile.apple.iOS.iPhone.animation-desk'
  end
  
  factory :nl_ios_app, class: App do
    channel 'apple'
    os 'iOS'
    device 'iPhone'
    name 'Noteledge Cloud iOS iPhone'
    external_id 'com.kdanmobile.apple.iOS.iPhone.noteledge'
  end
end
