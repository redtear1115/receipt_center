FactoryGirl.define do
  factory :receipt do
    timestamp = Time.zone.now
    purchased_at timestamp
  end
end
