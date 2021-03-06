FactoryGirl.define do
  factory :ad_ios_pack, class: Pack do
    name 'C365 for Animation Desk Monthly'
    external_id 'com.kdanmobile.animation-desk.c365.month'
    subscribable true
    extendable true
    period_num 1
    period_unit 'month'
  end
  
  factory :nl_ios_pack, class: Pack do
    name 'C365 for Noteledge Monthly'
    external_id 'com.kdanmobile.noteledge.c365.month'
    subscribable true
    extendable true
    period_num 1
    period_unit 'month'
  end
  
  factory :ad_ios_deluxe_pack, class: Pack do
    name 'Deluxe for Animation Desk Monthly'
    external_id 'com.kdanmobile.noteledge.deluxe.month'
    subscribable true
    extendable false
    period_num 1
    period_unit 'month'
  end
  
  factory :nl_ios_deluxe_pack, class: Pack do
    name 'Deluxe for Noteledge Monthly'
    external_id 'com.kdanmobile.noteledge.deluxe.month'
    subscribable true
    extendable false
    period_num 1
    period_unit 'month'
  end
  
  factory :ad_ios_cloud_pack, class: Pack do
    name 'Cloud for Animation Desk Monthly'
    external_id 'com.kdanmobile.animation-desk.cloud.month'
    subscribable true
    extendable false
    period_num 1
    period_unit 'month'
  end
  
  factory :ad_ios_storage_10g, class: Pack do
    name '10g Storage'
    external_id 'com.kdanmobile.animation-desk.storage.10g'
    subscribable false
    extendable false
  end
  
  factory :ad_ios_credit_20, class: Pack do
    name '20 Credit'
    external_id 'com.kdanmobile.animation-desk.credit.20'
    subscribable false
    extendable false
  end
end
