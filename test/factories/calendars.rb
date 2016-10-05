FactoryGirl.define do
  factory :calendar do
    association :project
    is_funded_default 1
    url "MyString"
    region 1
  end
end
