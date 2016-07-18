FactoryGirl.define do
  factory :project do
    name "Project Name"
    start "2016-01-08"
    finish "2016-07-08"
    region 1
    association :primary_partner_organisation, factory: :organisation
    association :resident_champion, factory: :member
    association :resident_seconder, factory: :member
  end
end
