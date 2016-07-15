FactoryGirl.define do
  factory :partner do
    start "2016-07-08"
    finish "2016-07-08"
    partner_type 1
    association :organisation
    association :project
  end
end
