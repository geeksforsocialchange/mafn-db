FactoryGirl.define do
  factory :question do
    category 0
    question "Is there anything specific preventing you from taking part which you would like to change?"
  end

  factory :question_with_response, class: Question do
    category 0
    question "I feel like I belong to this neighbourhood"
    response ["Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree"]
  end

end
