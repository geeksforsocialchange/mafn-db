FactoryGirl.define do
  factory :member do
    first_name "Jane"
    last_name  "Doe"
    region 0
    dob  Date.parse("Fri, 15 Jun 1956")
    entity_id 1
    created_at Time.parse("Wed, 15 Jun 2016 12:00:00")
    tel "0800 893731"
    mob "07688 349455"
    email "jane_doe@test.net"
  end
end
