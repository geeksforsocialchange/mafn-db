require 'test_helper'

class ExportQuestionnaireTest < ActionDispatch::IntegrationTest

  setup do
    @events = create(:event)
  end

  test "questionnaire spreadsheet export" do
    sheet = load_spreadsheet "questionnaire"

    # We're just testing the first row
    head = sheet.row(1)
    content = sheet.row(2)

    assert_equal head[0], "Participant External ID"
    assert_equal head[1], "Questionnaire Type"
    assert_equal head[2], "Have any of the following circumstances changed for you"
    assert_equal head[3], "Postcode"
    assert_equal head[4], "What is your marital status"
    assert_equal head[5], "Education level"
    assert_equal head[6], "Current Employment status"
    assert_equal head[7], "Anyone Sick or disabled you care for"
    assert_equal head[8], "Do you have any long standing conditions"
    assert_equal head[9], "Please name/briefly describe condition"
    assert_equal head[10], "To what extent do you feel that you live in an age-friendly neighbourhood?"
    assert_equal head[11], "Do you use a smartphone, computer, tablet?"
    assert_equal head[12], "Do you belong to any social networking websites or forums?"
    assert_equal head[13], "Other social network"
    assert_equal head[14], "Do you use email"
    assert_equal head[15], "Hours on social media, websites, email"
    assert_equal head[16], "participant- do you currently volunteer"
    assert_equal head[17], "participant- Do you want to volunteer?"
    assert_equal head[18], "friends and family-how often do you meet up ?"
    assert_equal head[19], "friends and family-speak on the phone"
    assert_equal head[20], "friends and family- send receive texts"
    assert_equal head[21], "People can change things in my local area if they work together"
    assert_equal head[22], "I can influence decisions affecting my local area"
    assert_equal head[23], "How often do you talk to your neighbours?"
    assert_equal head[24], "I feel like I belong to this neighbourhood"
    assert_equal head[25], "The friendships and associations I have with other people in my neighbourhood mean a lot to me"
    assert_equal head[26], "If I needed advice about something I could go to someone in my neighbourhood"
    assert_equal head[27], "I borrow things and exchange favours with my neighbours"
    assert_equal head[28], "I would be willing to work together with others on something to improve my neighbourhood"
    assert_equal head[29], "I regularly stop and talk with people in my neighbourhood"

  end
end
