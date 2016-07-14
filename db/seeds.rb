# Load questions from YML
event_feedback_data   = YAML.load_file "db/questions/event_feedback.yml"
community_audit_data  = YAML.load_file "db/questions/community_audit.yml"
membership_data       = YAML.load_file "db/questions/membership.yml"

# Function to create questions en masse
def create_questions(questions, category = 0)
  output = []
  questions.each_with_index do |q|
    new_question = Question.create!(question: q[0], response: q[1], category: category)
    output << new_question
  end
  return output
end

# Create the questions
event_feedback_questions  = create_questions(event_feedback_data, 1)
community_audit_questions = create_questions(community_audit_data)
membership_questions      = create_questions(membership_data)

# Create question sets
event_feedback  = QuestionSet.create!(title: "Event Feedback")
community_audit = QuestionSet.create!(title: "Community Audit")
membership      = QuestionSet.create!(title: "Membership")

# Add questions to question set
def create_question_set(question_set, questions)
  questions.each_with_index do |q, idx|
    QuestionList.create!(
                          question_set: question_set,
                          question: q,
                          weight: idx
                        )
  end
end

create_question_set(event_feedback, event_feedback_questions)
create_question_set(community_audit, community_audit_questions)
create_question_set(membership, membership_questions)

# Import events
`rake calendar:import`
