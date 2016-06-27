FactoryGirl.define do
  factory :question_set do
    title "Community Audit"
    factory :question_set_with_questions do
      after(:create) do |question|
        create(:question, question_set: question_set)
      end
    end
  end
end
