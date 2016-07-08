FactoryGirl.define do
  factory :representative do
    job_title "Representative Job Title"
    start "2016-07-08"
    finish "2016-07-08"
    association :member
    association :organisation
  end
end
