FactoryGirl.define do
  factory :question_list do
    association :question
    association :question_set
    weight 1
  end
end
