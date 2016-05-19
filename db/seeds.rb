# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Seed users with dummy data
if Member.all.length < 5
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
                  )
  end
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
