def generate_events_feedback(events)
  @events = events
  array = []
  array << [
    "Event External ID",
    "How Did You Find Out About Today",
    "Other How you found out",
    "Have previously attended an event or activity",
    "Why did you attend today",
    "Would you recommend future events/activities to others?",
    "To what extent do you feel that you live in an age-friendly neighbourhood?",
    "Could you tell us why you think this?",
    "I can influence decisions affecting my local area",
    "People can change things in my local area if they work together",
    "Could you tell us why you think this?",
    "Do you have any comments or feedback about the day for us?",
    "Member ID"
  ]
  @events.each do |event|
    event.responders.each do |member|
      array << [
        # "Event External ID"
        "MMU-" + event.id.to_s,
        # "How Did You Find Out About Today"
        get_response(member, "How did you find out about today?", entity: event.entity_id),
        # "Other How you found out"
        get_response(member, "How did you find out about today? (other reason)", entity: event.entity_id),
        # "Have previously attended an event or activity"
        Member.find(member).events.count,
        # "Why did you attend today"
        get_response(member, "Why did you attend today?", entity: event.entity_id),
        # NOT CAPTURING: "Would you recommend future events/activities to others?"
        "",
        # "To what extent do you feel that you live in an age-friendly neighbourhood?"
        get_response(member, "My neighbourhood is…", entity: event.entity_id),
        # "Could you tell us why you think this?"
        get_response(member, "Can you tell us what you would do to improve the area?", entity: event.entity_id),
        # "I can influence decisions affecting my local area"
        get_response(member, "I can influence decisions affecting my local area", entity: event.entity_id),
        # "People can change things in my local area if they work together"
        get_response(member, "People can change things in my local area if they work together", entity: event.entity_id),
        # "Could you tell us why you think this?"
        get_response(member, "Can you tell us what you would do to improve the area?", entity: event.entity_id),
        # "Do you have any comments or feedback about the day for us?"
        get_response(member, "Do you have any comments or feedback about today?", entity: event.entity_id),
        "MMU-" + Member.find(member).id.to_s
      ]
    end
  end
  return array
end

def export_events_feedback(wb)
  wb.workbook.add_worksheet(name: "Events Feedback") do |sheet|
    events = Event.all
    generate_events_feedback(events).each do |row|
      sheet.add_row row
    end
  end
  return wb
end
