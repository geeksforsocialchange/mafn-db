namespace :imports do

  task calendar: :environment do
    CalendarImportJob.perform_later
  end

  task calendar_destroy: :environment do
    Event.destroy_all
  end

  task members: :environment do
    require 'roo'
    wb = Roo::Excelx.new("#{Rails.root}/db/imports/members.xlsx")
    rows = wb.sheet(0).drop(1)
    rows.each do |row|
      raw_region = row[19]
      if raw_region == "Hulme"
        region = 0
      elsif raw_region == "Moston"
        region = 2
      elsif raw_region == "Burnage"
        region = 1
      end
      next unless row[1] && row[2]
      @member = Member.create!(
        # 0. Email
        email: row[0],
        # 1. First Names
        first_name: row[1],
        # 2. Last Name
        last_name: row[2],
        # 3. Age
        dob: row[3].to_i.years.ago.to_date,
        # 5. PresumedResidentStatus
        is_resident: row[5],

        # 11. Tel
        tel: row[11],
        # 12. Mob
        mob: row[12],
        # 19. File
        region: region
      )

      # 4. Gender
      case row[4]
      when "Woman"
        gender = 0
      when "Man"
        gender = 1
      when "Other"
        gender = 2
      else
        gender = 3
      end
      QuestionResponse.create!(
        question: Question.where(question: "Gender").first,
        response: gender,
        member_id: @member.id,
        entity_id: @member.entity_id
      )
      # 6. Time in area
      if row[6]
        QuestionResponse.create!(
          question: Question.where(question: "How long have you lived in your ward in years?").first,
          response: row[6],
          member_id: @member.id,
          entity_id: @member.entity_id
        )
      end

      # 9. Address
      street = row[9]
      # 10. Postcode
      postcode = row[10]
      if street
        @location = Location.create!(
          name: "#{@member.name}'s house",
          line1: street,
          postcode: postcode
        )
        MemberLocation.create!(
          member: @member,
          location: @location
          # TODO: from
        )
      end

      # 7. Organisation
      organisation = row[7]
      # 8. Role
      role = row[8]
      if organisation
        @organisation = Organisation.where(name: organisation).first
        unless @organisation
          @organisation = Organisation.create!(
            name: organisation
          )
        end
        Representative.create!(
          job_title: role,
          member: @member,
          organisation: @organisation
        )
      end

      # NOT USED
      # 13. Preferred contact
      # 14. When added
      # 15. GROUPS ATTENDED
      # 16. DATE ADDED
      # 17. Region
      # 18. GROUPS THEY ATTEND
    end

  end
end
