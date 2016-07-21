def export_projects(wb)
  wb.workbook.add_worksheet(name: "Projects") do |sheet|
    sheet.add_row [
      "External Identifier",
      "Organisation Name",
      "Main-Street Address",
      "Main-City",
      "Main-Postal Code",
      "Main-Country",
      "GM Region",
      "Manchester ward",
      "Project Start Date",
      "Project End Date",
      "Type",
      "Purpose",
      "what will project do",
      "no. older people involved in design",
      "How involved- evidence",
      "Themes",
      "Other themes",
      "Categories",
      "Project Cost",
      "Ecorys - No of delivery partners",
      "delivery partners- who- how involved",
      "Regular participants"
    ]
    @projects.each do |project|
      # We're only interested in the project for this
      params = { entity: project.entity }

      # Need to prebuild this as it goes in one cell
      categories = []
      [ "Categories a) one-to-one intervention",
        "Categories b) group intervention",
        "Categories c) service provision intervention",
        "Categories d) wider community development/neighbourhood intervention"
      ].each do |c|
        if get_response(false, c, params) == "Yes"
          categories << c
        end
      end
      categories = categories.join(", ")

      # Just in case this is null
      loc = []
      if project.primary_partner_organisation && project.primary_partner_organisation.location
        # "Main-Street Address"
        loc << project.primary_partner_organisation.location.line1
        # "Main-City"
        loc << project.primary_partner_organisation.location.city
        # "Main-Postal Code"
        loc << project.primary_partner_organisation.location.postcode
      else
        loc << ""
        loc << ""
        loc << ""
      end

      # Output the row
      sheet.add_row [
        # "External Identifier"
        "MMU-#{project.id}",
        # "Organisation Name" (Presuming this means "project name" in our schema)
        project.name,
        # "Main-Street Address"
        loc[0],
        # "Main-City"
        loc[1],
        # "Main-Postal Code"
        loc[2],
        # "Main-Country" // please autofill with United Kingdom- will help with geo-coding
        "United Kingdom",
        # "GM Region" // please autofill with Manchester
        "Manchester",
        # "Manchester ward" // Burnage, Moss Side & Hulme, Moston
        project.region,
        # "Project Start Date" (Y-M-D)
        ymd(project.start),
        # "Project End Date"
        ymd(project.finish),
        # "Type" // New, Existing, Continuation, Scaled-up
        get_response(false, "Innovation - Please select one", params),
        # "Purpose"
        get_response(false, "Outline of Project/Activity or Event", params),
        # "what will project do"
        get_response(false, "Outline Timetable", params),
        # "no. older people involved in design"
        get_response(false, "How many older people have been involved in developing this project?", params),
        # "How involved- evidence"
        get_response(false, "Please describe how older people have been involved in developing the project", params),
        # SKIP. Just using next field. "Themes" // Physical space Physical activity Digital Inclusion Intergenerational Activities Outdoor Spaces and Buildings Housing Transport Skills & Employment Financial Inclusion Social Action Other.
        "",
        # "Other themes"
        get_response(false, "What is the project theme?", params),
        # "Categories" // a) one-to-one intervention b) group intervention c) service provision intervention d) wider community development/neighbourhood intervention
        categories,
        # "Project Cost"
        get_response(false, "Total Project Cost (inc. VAT)", params),
        # "Ecorys - No of delivery partners"
        get_response(false, "Other Supporters", params),
        # "delivery partners- who- how involved"
        get_response(false, "What other delivery partners are invovled?", params),
        # "Regular participants"
        get_response(false, "Regular participants?", params)
      ]
    end
  end
  return wb
end
