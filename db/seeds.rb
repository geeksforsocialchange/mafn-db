# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

Faker::Config.locale = 'en-GB'

# Seed users with dummy data
50.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  dob = Faker::Date.between(100.years.ago, 18.years.ago)
  tel = Faker::PhoneNumber.phone_number
  mob = Faker::PhoneNumber.cell_phone
  Member.create!( first_name: first_name,
                  last_name: last_name,
                  email: email,
                  dob: dob,
                  tel: tel,
                  mob: mob,
                  is_resident: true,
                  region: rand(0..2)
                )
end


# Seed questions with actual data
event_feedback_data   = YAML.load_file "db/questions/event_feedback.yml"
community_audit_data  = YAML.load_file "db/questions/community_audit.yml"
membership_data       = YAML.load_file "db/questions/membership.yml"

def create_questions(questions, category = 0)
  output = []
  questions.each_with_index do |q|
    new_question = Question.create!(question: q[0], response: q[1], category: category)
    output << new_question
  end
  return output
end

event_feedback_questions  = create_questions(event_feedback_data, 1)
community_audit_questions = create_questions(community_audit_data)
membership_questions      = create_questions(membership_data)

# Create question sets
event_feedback  = QuestionSet.create!(title: "Event Feedback")
community_audit = QuestionSet.create!(title: "Community Audit")
membership      = QuestionSet.create!(title: "Membership")

def create_question_set(question_set, questions)
  questions.each_with_index do |q, idx|
    QuestionList.create!(
                          question_set_id: question_set.id,
                          question_id: q.id,
                          weight: idx
                        )
  end
end

create_question_set(event_feedback, event_feedback_questions)
create_question_set(community_audit, community_audit_questions)
create_question_set(membership, membership_questions)

def answer_question(  question = Question.where(category: 0).order("RANDOM()").limit(1).first,
                      target = false,
                      responder = Member.order("RANDOM()").limit(1).first )
  if question.response
    option_count = JSON.parse(question.response).length
    response = rand(0..option_count)
  else
    response = Faker::Lorem.sentence
  end
  if target
    subject = Entity.find(target.entity_id)
  else
    subject = Entity.find(responder.entity_id)
  end
  QuestionResponse.create!(
    response: response,
    question: question,
    responder: responder,
    subject: subject,
  )
end

# Answer some random questions
500.times do |n|
  answer_question
end

# Create locations
50.times do |n|
  name = Faker::Company.name
  line1 = Faker::Address.street_name
  line2 = Faker::Address.street_name
  city = Faker::Address.city
  postcode = Faker::Address.postcode
  latitude = Faker::Address.latitude
  longitude = Faker::Address.longitude
  Location.create!(
    name: name,
    line1: line1,
    line2: line2,
    city: city,
    postcode: postcode,
    latitude: latitude,
    longitude: longitude
  )
end

# Give every member a location
Member.all.each_with_index do |member, idx|
  MemberLocation.create!(
    member: member,
    location: Location.find(idx + 1),
    from: Faker::Date.between(20.years.ago, 0.years.ago)
  )
end

# Import events
`rake calendar:import`

# Assign some random attendances and do feedback
event_count = Event.count
Member.all.each do |member|
  # Create 5 random numbers between 1 and event count
  attendances = (1..event_count).to_a.sort{ rand() - 0.5 }[0..5]
  attendances.each do |attendance|
    event = Event.find(attendance)
    # Make an attendance for each one
    Attendance.create(event: event, member: member)
    # Answer the feedback form
    Question.where(category: 1).each do |q|
      answer_question(q, event, member)
    end
  end
end
