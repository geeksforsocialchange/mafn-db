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

    # TODO: implement projects
    assert_equal head[0], "Project External ID"

    # TODO: find out if MAFN want to store this as a bool or if we're presuming yes
    assert_equal head[1], "Consent Given"

    # Our ID
    assert_equal head[2], "Participant External ID Field"
    assert_equal content[2], 1

    # Member's name
    assert_equal head[3], "First Name"
    assert_equal content[3], "Jane"
    assert_equal head[4], "Last Name"
    assert_equal content[4], "Doe"

    # TODO: confirm this is the same as the created at in the database date and we don't need another
    assert_equal head[5], "Date Engaged with project"
    assert_equal content[5], Date.parse("Wed, 15 Jun 2016")

    # TODO: confirm which phone number is more important, mobile or telephone
    assert_equal head[6], "Phone Number"
    assert_equal content[6], "0800 893731"

    assert_equal head[7], "Email Address"
    assert_equal content[7], "jane_doe@test.net"

    assert_equal head[8], "Year of Birth"
    assert_equal content[8], 1956

    # TODO: confirm that they really want gender stored like this - seems silly
    assert_equal head[9], "Gender"
    assert_equal head[10], "Other Gender Please State"
    assert_equal head[11], "Gender same as at Birth"

    # TODO: add in bool for if they live in a ward or not
    assert_equal head[12], "Do you live in an Ambition for Ageing Ward"

    # TODO: figure out how to calculate this
    assert_equal head[13], "How long have you lived in your ward"

    # TODO: work out where to store this
    assert_equal head[14], "Current Employment status"
    # TODO: work out if this is REALLY a column or not
    assert_equal head[15], "Prefer not to say"

    # TODO: work out if this is really how they want fields from here stored
    assert_equal head[16], "Ethnic Background: Asian/ Asian British	Asian/ Asian British Other"
    assert_equal head[17], "Ethnic Background: Black/ Black British	Black Black British Other"
    assert_equal head[18], "Ethnic Background: White British"
    assert_equal head[19], "White Other"
    assert_equal head[20], "Any Other Background"
    assert_equal head[21], "Any mixed Background"
    assert_equal head[22], "Religion"
    assert_equal head[23], "Other religion"
    assert_equal head[24], "Sexual Orientation"

    # TODO: find out where this comes from
    assert_equal head[25], "What do you think makes an age friendly neighbourhood"
  end

end
