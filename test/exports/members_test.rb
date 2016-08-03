require 'test_helper'

class ExportMembersTest < ActionDispatch::IntegrationTest

  test "member spreadsheet report" do
    require "#{Rails.root}/app/jobs/helpers/members.rb"
    @members = create_list(:member, 3)
    sheet = generate_members(@members)

    # We're just testing that the one member works
    head = sheet[0]
    content = sheet[1]

    #======#
    # TODO #
    #======#

    # TODO: implement projects
    assert_equal head[0], "Project External ID"


    # TODO: confirm this is the same as the created at in the database date and we don't need another
    assert_equal head[5], "Date Engaged with project"


    #======#
    # DONE #
    #======#

    assert_equal head[1], "Consent Given"
    assert_equal content[5], Date.parse("Wed, 15 Jun 2016")
    assert_equal head[6], "Phone Number"
    assert_equal content[6], "0800 893731"
    assert_equal head[15], "Prefer not to say"
    assert_equal head[16], "Ethnic Background: Asian/ Asian British"
    assert_equal head[17], "Asian/ Asian British Other"
    assert_equal head[18], "Ethnic Background: Black/ Black British"
    assert_equal head[19], "Black Black British Other"
    assert_equal head[20], "Ethnic Background: White British"
    assert_equal head[21], "White Other"
    assert_equal head[22], "Any Other Background"
    assert_equal head[23], "Any mixed Background"
    assert_equal head[27], "What do you think makes an age friendly neighbourhood"
    assert_equal head[28], "Education level"


    # Our ID
    assert_equal head[2], "Participant External ID Field"
    assert_equal content[2], "MMU-" + @members.first.id.to_s

    # Member's name
    assert_equal head[3], "First Name"
    assert_equal content[3], "Jane"
    assert_equal head[4], "Last Name"
    assert_equal content[4], "Doe"

    assert_equal head[7], "Email Address"
    assert_equal content[7], "jane_doe@test.net"

    assert_equal head[8], "Year of Birth"
    assert_equal content[8], 1956

    assert_equal head[9], "Gender"
    assert_equal head[10], "Other Gender Please State"
    assert_equal head[11], "Gender same as at Birth"

    assert_equal head[12], "Do you live in an Ambition for Ageing Ward"

    assert_equal head[13], "How long have you lived in your ward"

    assert_equal head[14], "Current Employment status"

    assert_equal head[24], "Religion"
    assert_equal head[25], "Other religion"
    assert_equal head[26], "Sexual Orientation"

  end

end
