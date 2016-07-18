namespace :test_data do

  task create: :environment do
    require 'faker'

    Faker::Config.locale = 'en-GB'

    # Create Users
    20.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.email
      dob = Faker::Date.between(100.years.ago, 18.years.ago)
      tel = Faker::PhoneNumber.phone_number
      mob = Faker::PhoneNumber.cell_phone
      ethnic_background_other = Faker::Lorem.word
      Member.create!( first_name: first_name,
                      last_name: last_name,
                      email: email,
                      dob: dob,
                      tel: tel,
                      mob: mob,
                      is_resident: true,
                      ethnic_background: rand(0..13),
                      ethnic_background_other: ethnic_background_other,
                      region: rand(0..2)
                    )
    end

    # Create Locations
    40.times do |n|
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

    # Create Organisations
    20.times do |o|
      Organisation.create!(
        name: Faker::Company.name,
        location: Location.find(o + 20)
      )
    end

    # Create Projects
    orgs = Organisation.order("RANDOM()").limit(20)
    members = Member.order("RANDOM()").limit(40)
    20.times do |p|
      Project.create!(
        name: Faker::Company.name,
        start: Faker::Date.between(20.years.ago, 0.years.ago),
        primary_partner_organisation:  orgs[p],
        region: rand(0..3),
        resident_champion: members[(p * 2 - 1)],
        resident_seconder: members[(p * 2)]
      )
    end


    # Create various things that belong to Members

    event_count = Event.count
    Member.all.each do |member|
      # Assign some random attendances and do feedback
      # Create 5 random events between 1 and event count
      attendances = (1..event_count).to_a.sort{ rand() - 0.3 }[0..3]
      attendances.each do |attendance|
        event = Event.find(attendance)
        # Make an attendance for each one
        Attendance.create(event: event, member: member)
        # Answer the feedback form
        Question.where(category: 1).each do |q|
          answer_question(q, member, event)
        end
      end

      # Answer the membership survey once
      QuestionSet.where(title: "Membership").first.questions.each do |q|
        answer_question(q, member)
      end

      # Do the Community Audit once
      QuestionSet.where(title: "Community Audit").first.questions.each do |q|
        answer_question(q, member)
      end

      # Join an Organisation, maybe
      if [true, false, false].sample
        Representative.create!(
          job_title: Faker::Name.title,
          start: Faker::Date.between(20.years.ago, 0.years.ago),
          organisation: Organisation.order("RANDOM()").limit(1).first,
          member: member
        )
      end

      # Join some Projects
      rand(0..2).times do |p|
        Volunteer.create!(
          role: Faker::Name.title,
          is_leader: [true, false, false, false].sample,
          start: Faker::Date.between(20.years.ago, 0.years.ago),
          member: member,
          project: Project.order("RANDOM()").limit(1).first
        )
      end
    end

    # Assign events to projects
    Event.all.each do |event|
      next if [true, true, false].sample
      Arranger.create!(
        project: Project.order("RANDOM()").limit(1).first,
        event: event
      )
    end


  end

  def answer_question(  question = Question.where(category: 0).order("RANDOM()").limit(1).first,
                        responder = Member.order("RANDOM()").limit(1).first,
                        target = false
                    )
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
end
