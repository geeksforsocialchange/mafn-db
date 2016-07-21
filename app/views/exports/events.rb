# vim: set syntax=ruby:
wb = xlsx_package.workbook
wb.add_worksheet(name: "Events") do |sheet|
  sheet.add_row [ "Project External ID",
                  "Event Name",
                  "Event External ID",
                  "Date Of Event",
                  "Type of Event",
                  "Other Event",
                  "No of attendees"
                ]
  @events.each do |event|
    if event.project
      sheet.add_row [ "MMU-" + event.project.id.to_s,
                      event.name,
                      "MMU-" + event.id.to_s,
                      event.ydm,
                      event.event_type,
                      event.event_type_other,
                      event.attendees
                    ]
    end
  end
end
