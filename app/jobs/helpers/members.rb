def export_members(wb)
  wb.workbook.add_worksheet(name: "Members") do |sheet|
    sheet.add_row [
      "Project External ID",
      "Consent Given",
      "Participant External ID Field",
      "First Name",
      "Last Name",
      "Date Engaged with project",
      "Phone Number",
      "Email Address",
      "Year of Birth",
      "Gender",
      "Other Gender Please State",
      "Gender same as at Birth",
      "Do you live in an Ambition for Ageing Ward",
      "How long have you lived in your ward",
      "Current Employment status",
      "Prefer not to say",
      "Ethnic Background: Asian/ Asian British",
      "Asian/ Asian British Other",
      "Ethnic Background: Black/ Black British",
      "Black Black British Other",
      "Ethnic Background: White British",
      "White Other",
      "Any Other Background",
      "Any mixed Background",
      "Religion",
      "Other religion",
      "Sexual Orientation",
      "What do you think makes an age friendly neighbourhood"
    ]
    @members.each do |member|
      ethnicity = member.export_ethnicity
      sheet.add_row [
        # "Participant External ID"
        member.volunteers.pluck(:project_id).map { |p| "MMU-#{p}" }.join(", "),
        # "Consent Given"
        "Yes",
        member.id,
        member.first_name,
        member.last_name,
        # "Date Engaged with project"
        member.created_at,
        member.tel,
        member.email,
        member.dob.year,
        get_response(member, "Gender"),
        get_response(member, "Gender -- other"),
        get_response(member, "Is this the gender you were assigned at birth?"),
        member.is_resident?,
        get_response(member, "How long have you lived in your ward in years?"),
        get_response(member, "What is your current employment status?"),
        # MISTAKE COLUMN: "Prefer not to say"
        # Is this perhaps 'Ethnicity - prefer not to say'?
        "",
        # Ethnicities
        ethnicity[0],
        ethnicity[1],
        ethnicity[2],
        ethnicity[3],
        ethnicity[4],
        ethnicity[5],
        ethnicity[6],
        ethnicity[7],
        get_response(member, "What is your religion?"),
        # "Other religion"
        get_response(member, "Other religion"),
        get_response(member, "Sexual orientation"),
        get_response(member, "What do you think makes an ‘age friendly neighbourhood’?")
      ]
    end
  end
  return wb
end