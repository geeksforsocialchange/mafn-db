FactoryGirl.define do
  factory :member do
    first_name "Jane"
    last_name  "Doe"
    dob   { 60.years.ago }
    entity_id 1
  end
end
