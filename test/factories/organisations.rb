FactoryGirl.define do
  factory :organisation do
    name "Organisation Name"
    association :location
  end
end
