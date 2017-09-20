FactoryGirl.define do
  factory :app do
    channel 'apple'
    os 'iOS'
    device 'iPhone'
    name 'my first app'
    external_id 'com.kdanmobile.apple.iOS.iPhone.my-first-app'
  end
end
