def export_events_demographics(wb)
  wb.workbook.add_worksheet(name: "Event Demographics") do |sheet|
    sheet.add_row [
        "Event External ID",
        "Who do you live with",
        "Other living arrangement",
        "What is your marital status",
        "What is your year of birth",
        "Gender",
        "Is your gender the same as assigned at birth",
        "Sexual Orientation",
        "How long have you lived in your ward",
        "Ethnic Background: Asian/ Asian British",
        "Asian/ Asian British Other",
        "Ethnic Background: Black/ Black British",
        "Black Black British Other",
        "Ethnic Background: White British",
        "White Other",
        "Any Other Background",
        "Prefer not to say",
        "Religion",
        "Other religion",
        "Anyone Sick or disabled you care for",
        "Do you have any long standing conditions",
        "Please name/briefly describe condition",
        "Education level",
        "Current Employment status",
        "Postcode"
      ]
    @events.each do |event|
      event.members.each do |member|
        ethnicity = member.export_ethnicity
        sheet.add_row [
          "MMU-" + event.id.to_s,
          get_response(member, "What is your living situation?"),
          get_response(member, "What is your living situation? (other)"),
          get_response(member, "What is your marital status?"),
          member.dob.year,
          get_response(member, "Gender"),
          get_response(member, "Is this the gender you were assigned at birth?"),
          get_response(member, "Sexual orientation"),
          get_response(member, "How long have you lived in your ward in years?"),
          ethnicity[0],
          ethnicity[1],
          ethnicity[2],
          ethnicity[3],
          ethnicity[4],
          ethnicity[5],
          ethnicity[6] || ethnicity[7],
          member.ethnic_background.nil? ? "Prefer not to say" : "",
          get_response(member, "What is your religion?"),
          get_response(member, "Other religion"),
          get_response(member, "Is there anyone who is sick, disabled or needs support whom you look after or give special help to?"),
          get_response(member, "Do you have any long standing physical or mental illness or disability?"),
          get_response(member, "If so, please name/briefly describe condition"),
          get_response(member, "What is your highest level of education?"),
          get_response(member, "What is your current employment status?"),
          member.locations.empty? ? "" : member.locations.last.postcode
        ]
      end
    end
  end
  return wb
end
