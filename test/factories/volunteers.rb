FactoryGirl.define do
  factory :volunteer do
    role "Volunteer Role"
    is_leader false
    start "2016-07-08"
    finish "2016-07-08"
    association :member
    association :project
  end
end
