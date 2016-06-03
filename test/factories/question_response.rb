FactoryGirl.define do
  factory :question_response do
    association :responder, factory: :member
    question
    entity_id 1
    response "I struggle with mobility issues getting into some of the venues"
  end
end
