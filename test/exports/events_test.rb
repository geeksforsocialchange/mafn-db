require 'test_helper'

class ExportEventsTest < ActionDispatch::IntegrationTest

  test "event spreadsheet export" do
    require "#{Rails.root}/app/jobs/helpers/events.rb"
    @events = create_list(:event, 3)
    @events.first.project = create(:project)
    @events.first.members = create_list(:member, 5)
    sheet = generate_events(@events)
    head = sheet[0]
    content = sheet[1]

    assert_equal head[0], "Project External ID"
    assert_equal content[0], "MMU-" + @events.first.project.id.to_s

    assert_equal head[1], "Event Name"
    assert_equal content[1], "Healthy Relationships"

    # Our internal ID - can add some arbritrary number to this later if needed
    assert_equal head[2], "Event External ID"
    assert_equal content[2], "MMU-" + @events.first.id.to_s

    assert_equal head[3], "Date Of Event"
    assert_equal content[3], "2016-06-04"

    # TODO: find out what MAFN want here
    assert_equal head[4], "Type of Event"

    # TODO: find out what this is for
    assert_equal head[5], "Other Event"

    assert_equal head[6], "No of attendees"
    assert_equal content[6], 5
  end
end
