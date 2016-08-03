def generate_events events
  @events = events
  array = []
  array << [  "Project External ID",
              "Event Name",
              "Event External ID",
              "Date Of Event",
              "Type of Event",
              "Other Event",
              "No of attendees"
            ]
  @events.each do |event|
    if event.project
      array << [ "MMU-" + event.project.id.to_s,
                  event.name,
                  "MMU-" + event.id.to_s,
                  event.ydm,
                  event.event_type,
                  event.event_type_other,
                  event.attendees
                ]
    end
  end
  return array
end

def export_events(wb)
  wb.workbook.add_worksheet(name: "Events") do |sheet|
    events = Event.all
    generate_events(events).each do |row|
      sheet.add_row row
    end
  end
  return wb
end
