require 'test_helper'

class ExportMembersTest < ActionDispatch::IntegrationTest

  setup do
    @members = create(:member)
  end

  test "member spreadsheet report" do
    sheet = load_spreadsheet "members"

    # We're just testing that the one member works
    head = sheet.row(1)
    content = sheet.row(2)

    assert_equal head[0], "Project External ID"
    assert_equal head[1], "Consent Given"
    assert_equal head[2], "Participant External ID Field"
    assert_equal head[3], "First Name"
    assert_equal head[4], "Last Name"
    assert_equal head[5], "Date Engaged with project"
    assert_equal head[6], "Phone Number"
    assert_equal head[7], "Email Address"
    assert_equal head[8], "Year of Birth"
    assert_equal head[9], "Gender"
    assert_equal head[10], "Other Gender Please State"
    assert_equal head[11], "Gender same as at Birth"
    assert_equal head[12], "Do you live in an Ambition for Ageing Ward"
    assert_equal head[13], "How long have you lived in your ward"
    assert_equal head[14], "Current Employment status"
    assert_equal head[15], "Prefer not to say"
    assert_equal head[16], "Ethnic Background: Asian/ Asian British	Asian/ Asian British Other"
    assert_equal head[17], "Ethnic Background: Black/ Black British	Black Black British Other"
    assert_equal head[18], "Ethnic Background: White British"
    assert_equal head[19], "White Other"
    assert_equal head[20], "Any Other Background"
    assert_equal head[21], "Any mixed Background"
    assert_equal head[22], "Religion"
    assert_equal head[23], "Other religion"
    assert_equal head[24], "Sexual Orientation"
    assert_equal head[25], "What do you think makes an age friendly neighbourhood"
  end

end
