FactoryGirl.define do
  factory :arranger do
    association :project
    association :event
  end
end
