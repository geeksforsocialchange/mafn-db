require 'test_helper'

class ExportEventTest < ActionDispatch::IntegrationTest

  setup do
    @events = create(:event)
    # Add a few members to test the attendee count
    @events.members = create_list(:member, 5)
  end

  test "event spreadsheet export" do

    sheet = load_spreadsheet "events"
    head = sheet.row(1)
    content = sheet.row(2)

    #======#
    # TODO #
    #======#

    # TODO: implement project link
    assert_equal head[0], "Project External ID"
    # assert_equal content[0], ""

    #======#
    # DONE #
    #======#

    assert_equal head[1], "Event Name"
    assert_equal content[1], "Healthy Relationships"

    # Our internal ID - can add some arbritrary number to this later if needed
    assert_equal head[2], "Event External ID"
    assert_equal content[2], 1

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
