FactoryGirl.define do
  factory :member_location do
    association :member
    association :location
    from "2016-05-20"
  end
end
