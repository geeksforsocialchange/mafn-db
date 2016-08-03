require 'test_helper'

class ExportProjectsTest < ActionDispatch::IntegrationTest

  test "project spreadsheet export" do
    require "#{Rails.root}/app/jobs/helpers/projects.rb"
    @projects = create_list(:project, 3)
    sheet = generate_projects(@projects)

    # We're just testing the first row
    head = sheet[0]
    content = sheet[1]

    assert_equal head[0], "External Identifier"
    assert_equal content[0], "MMU-#{@projects.first.id}"

    assert_equal head[1], "Organisation Name"
    assert_equal content[1], @projects.first.name

    assert_equal head[2], "Main-Street Address"
    assert_equal content[2], @projects.first.primary_partner_organisation.location.line1
    assert_equal head[3], "Main-City"
    assert_equal content[3], @projects.first.primary_partner_organisation.location.city
    assert_equal head[4], "Main-Postal Code"
    assert_equal content[4], @projects.first.primary_partner_organisation.location.postcode

    assert_equal head[5], "Main-Country"
    assert_equal content[5], "United Kingdom"
    assert_equal head[6], "GM Region"
    assert_equal content[6], "Manchester"
    assert_equal head[7], "Manchester ward"
    assert_equal content[7], @projects.first.region

    assert_equal head[8], "Project Start Date"
    assert_equal content[8], "2016-01-08"

    assert_equal head[9], "Project End Date"
    assert_equal content[9], "2016-07-08"

    assert_equal head[10], "Type"
    assert_equal head[11], "Purpose"
    assert_equal head[12], "what will project do"
    assert_equal head[13], "no. older people involved in design"
    assert_equal head[14], "How involved- evidence"
    assert_equal head[15], "Themes"
    assert_equal head[16], "Other themes"
    assert_equal head[17], "Categories"
    assert_equal head[18], "Project Cost"
    assert_equal head[19], "Ecorys - No of delivery partners"
    assert_equal head[20], "delivery partners- who- how involved"
    assert_equal head[21], "Regular participants"

  end
end
