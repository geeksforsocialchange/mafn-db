# Load questions from YML
event_feedback_data   = YAML.load_file "db/questions/event_feedback.yml"
community_audit_data  = YAML.load_file "db/questions/community_audit.yml"
membership_data       = YAML.load_file "db/questions/membership.yml"
project_data          = YAML.load_file "db/questions/project.yml"

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
event_feedback_questions  = create_questions(event_feedback_data, "event")
community_audit_questions = create_questions(community_audit_data)
membership_questions      = create_questions(membership_data)
project_questions         = create_questions(project_data, "project")

# Create question sets
event_feedback  = QuestionSet.create!(title: "Event Feedback")
community_audit = QuestionSet.create!(title: "Community Audit")
membership      = QuestionSet.create!(title: "Membership")
projects        = QuestionSet.create!(title: "Projects")

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

# Create users
[
  "kim@alliscalm.net",
  "m.hammond@mmu.ac.uk",
  "k.wong@mmu.ac.uk",
  "s.white@mmu.ac.uk",
  "e.crompton@mmu.ac.uk",
  "m.youngson@mmu.ac.uk",
  "jude.wells@mmu.ac.uk",
  "jon-man.cheung@gmcvo.org.uk"
].each do |email|
  user = User.new
  user.email = email
  pw = SecureRandom.urlsafe_base64
  user.password = pw
  user.password_confirmation = pw
  user.save!
end

# Import events
`rake calendar:import`
