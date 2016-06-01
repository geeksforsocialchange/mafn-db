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
                  region: rand(0..2)
                )
end


# Seed questions with actual data
member_questions = YAML.load_file "db/questions/member.yml"

member_questions.each do |q|
  Question.create!(
                    question: q[0],
                    response: q[1],
                    category: 0,
                  )
end

# Create question set for these
member_set = QuestionSet.create!(title: "Community Audit")
member_set.questions = Question.where(category: 0)

# Answer some random questions
100.times do |n|
  response = Faker::Lorem.sentence
  question = Question.order("RANDOM()").limit(1).first
  responder = Member.order("RANDOM()").limit(1).first
  subject =  Entity.order("RANDOM()").limit(1).first
  QuestionResponse.create!(
    response: response,
    question: question,
    responder: responder,
    subject: subject,
  )
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

Member.all.each_with_index do |member, idx|
  MemberLocation.create!(
    member: member,
    location: Location.find(idx + 1),
    from: Faker::Date.between(20.years.ago, 0.years.ago)
  )
end
