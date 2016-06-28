require 'test_helper'

class ExportEventFeedbackTest < ActionDispatch::IntegrationTest

  setup do
    @events = create(:event)
  end

  test "event feedback spreadsheet export" do
    sheet = load_spreadsheet "events_feedback"

    # Only testing the first row
    head = sheet.row(1)
    content = sheet.row(2)

    assert_equal head[0], "Event External ID"
    assert_equal head[1], "How Did You Find Out About Today"
    assert_equal head[2], "Other How you found out"
    assert_equal head[3], "Have previously attended an event or activity"
    assert_equal head[4], "Why did you attend today"
    assert_equal head[5], "Would you recommend future events/activities to others?"
    assert_equal head[6], "To what extent do you feel that you live in an age-friendly neighbourhood?"
    assert_equal head[7], "Could you tell us why you think this?"
    assert_equal head[8], "I can influence decisions affecting my local area"
    assert_equal head[9], "People can change things in my local area if they work together"
    assert_equal head[10], "Could you tell us why you think this?"
    assert_equal head[11], "Do you have any comments or feedback about the day for us?"

  end
end
