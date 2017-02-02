def row(member, params)

  volunteering = []
  (1..3).each do |n|
    if member.volunteers[n]
      #"What is your role1":
      volunteering << member.volunteers[n].role
      #"What is your organisation1":
      volunteering << member.volunteers[n].project.name
      #"What date did you start1":
      volunteering << member.volunteers[n].start || member.volunteers[n].created_at
    else
      volunteering << ""
      volunteering << ""
      volunteering << ""
    end
  end

  if params.key?(:date_range)
    start_date = params[:date_range].first.to_date
  else
    start_date = ""
  end


  # Return this giant array
  [
    # "Participant External ID",
    "MMU-" + member.id.to_s,
    # "Questionnaire Type" [6 month, 12 month, Final],
    params[:order],
    # "Have any of the following circumstances changed for you",
    params[:followup] ? "Yes" : "No",
    # "Postcode",
    member.locations.empty? ? "" : member.locations.last.postcode,

    # MEMBERSHIP QUESTIONS
    # "What is your marital status",
    get_response(member, "What is your marital status?", params),
    # "Education level",
    get_response(member, "What is your highest level of education?", params),
    # "Current Employment status",
    get_response(member, "What is your current employment status?", params),
    # "Anyone Sick or disabled you care for",
    get_response(member, "Is there anyone who is sick, disabled or needs support whom you look after or give special help to?", params),
    # "Do you have any long standing conditions",
    get_response(member, "Do you have any long standing physical or mental illness or disability?", params),
    # "Please name/briefly describe condition",
    get_response(member, "If so, please name/briefly describe condition", params),

    # COMMUNITY AUDIT QUESTIONS
    # "To what extent do you feel that you live in an age-friendly neighbourhood?",
    get_response(member, "My Neighbourhood is...", params),
    # "Do you use a smartphone, computer, tablet?",
    get_response(member, "Do you use a computer, smartphone or tablet?", params),
    # "Do you belong to any social networking websites or forums?",
    get_response(member, "Please list any social networking websites that you use", params),
    # "Other social network",
    get_response(member, "Other social networking websites", params),
    # "Do you use email",
    get_response(member, "Do you use email?", params),
    # "Hours on social media, websites, email",
    get_response(member, "How many hours do you spend chatting or interacting with friends or family on social networking websites or email on a normal day?"),
    # "participant- do you currently volunteer",
    get_response(member, "Are you currently involved in organising or contribute to a local community group?", params),
    # "participant- Do you want to volunteer?",
    get_response(member, "Do you want to volunteer?", params),
    # "friends and family-how often do you meet up ?",
    get_response(member, "On average, how often do you - Send or receive text messages with friends, colleagues, family or neighbours", params),
    # "friends and family-speak on the phone",
    get_response(member, "On average, how often do you - Speak on the phone or skype with friends, family, colleagues or neighbours", params),
    # "friends and family- send receive texts",
    get_response(member, "On average, how often do you - Send or receive text messages with friends, colleagues, family or neighbours", params),
    # "People can change things in my local area if they work together",
    get_response(member, "People can change things in my local area if they work together", params),
    # "I can influence decisions affecting my local area",
    get_response(member, "I can influence decisions affecting my local area", params),
    # "How often do you talk to your neighbours?",
    get_response(member, "How often do you typically talk to your neighbours?", params),
    # "I feel like I belong to this neighbourhood",
    get_response(member, "I feel like I belong to this neighbourhood", params),
    # "The friendships and associations I have with other people in my neighbourhood mean a lot to me",
    get_response(member, "The friendship and associations I have with other people in my neighbourhood mean a lot to me", params),
    # "If I needed advice about something I could go to someone in my neighbourhood",
    get_response(member, "If I need advice about something, I could go to someone in my neighbourhood", params),
    # "I borrow things and exchange favours with my neighbours",
    get_response(member, "I borrow things and exchange favours with my neighbours", params),
    # "I would be willing to work together with others on something to improve my neighbourhood",
    get_response(member, "I would be willing to work together with others on something to improve my neighbourhood", params),
    # "I regularly stop and talk with people in my neighbourhood",
    get_response(member, "I regularly stop and talk to people in my neighbourhood", params),

    # Volunteer extra questions

    # "what functions do you carry out in your ambition for ageing volunteer role",
    member.volunteers.each.map { |v| "#{v.role} for #{v.project.name}"}.join(", "),
    # "Other function",
    "",
    # "How often do you carry out these activities",
    Arranger.where(project: member.projects).count,
    # "Do you volunteer with any other organisations, groups or communities not part of Ambition for Ageing?",
    get_response(member, "Are you currently involved in organising or contribute to a local community group?", params),
    #"How often do you generally volunteer with other organisations?",
    get_response(member, "If yes, How often do you volunteer?", params),

    # Extra col from Kim
    start_date,

    # "Role 1
    volunteering[0],
    # "Organisation 1
    volunteering[1],
    # "Date Started Role 1
    volunteering[2],
    # "Role 2
    volunteering[3],
    # "Organisation 2
    volunteering[4],
    # "Date Started Role 2
    volunteering[5],
    # "Role 3
    volunteering[6],
    # "Organisation 3
    volunteering[7],
    # "Date Started Role 3
    volunteering[8]
  ]
end

def generate_questionnaires(members)
  @members = members
  array = []
  array << [
    # Participant questions
    "Participant External ID",
    "Questionnaire Type",
    "Have any of the following circumstances changed for you",
    "Postcode",
    "What is your marital status",
    "Education level",
    "Current Employment status",
    "Anyone Sick or disabled you care for",
    "Do you have any long standing conditions",
    "Please name/briefly describe condition",
    "To what extent do you feel that you live in an age-friendly neighbourhood?",
    "Do you use a smartphone, computer, tablet?",
    "Do you belong to any social networking websites or forums?",
    "Other social network",
    "Do you use email",
    "Hours on social media, websites, email",
    "participant- do you currently volunteer",
    "participant- Do you want to volunteer?",
    "friends and family-how often do you meet up ?",
    "friends and family-speak on the phone",
    "friends and family- send receive texts",
    "People can change things in my local area if they work together",
    "I can influence decisions affecting my local area",
    "How often do you talk to your neighbours?",
    "I feel like I belong to this neighbourhood",
    "The friendships and associations I have with other people in my neighbourhood mean a lot to me",
    "If I needed advice about something I could go to someone in my neighbourhood",
    "I borrow things and exchange favours with my neighbours",
    "I would be willing to work together with others on something to improve my neighbourhood",
    "I regularly stop and talk with people in my neighbourhood",

    # Volunteer extra questions
    "what functions do you carry out in your ambition for ageing volunteer role",
    "Other function",
    "How often do you carry out these activities",
    "Do you volunteer with any other organisations, groups or communities not part of Ambition for Ageing?",
    "How often do you generally volunteer with other organisations?",

    # Extra column added by Kim
    "Response date",

    # Other roles
    "Role 1",
    "Organisation 1",
    "Date Started Role 1",
    "Role 2",
    "Organisation 2",
    "Date Started Role 2",
    "Role 3",
    "Organisation 3",
    "Date Started Role 3"
  ]
  @members.each do |member|
    if !@followup
      # If the user is asking for the initial questionnaire, just give the first answers
      array << row(member, { followup: false, order: "Initial" })
    else
      # Otherwise, give the responses since their first one, sorted by day
      days = member.response_days.drop(1)
      if days
        days.each_with_index do |date_range, idx|
          array << row(member, { followup: true, date_range: date_range, order: idx + 1 } )
        end
      end
    end
  end
  return array
end

def export_questionnaires(wb)
  title = @followup ? "Followup Questionnaire" : "Initial Questionnaire"
  wb.workbook.add_worksheet(name: title) do |sheet|
    members = Member.all
    generate_questionnaires(members).each do |row|
      sheet.add_row row
    end
  end
  return wb
end
