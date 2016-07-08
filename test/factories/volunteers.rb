FactoryGirl.define do
  factory :volunteer do
    role "MyString"
    is_leader false
    start "2016-07-08"
    finish "2016-07-08"
    member nil
    project nil
  end
end
