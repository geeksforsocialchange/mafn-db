require 'test_helper'

class ExportEventDemographicsTest < ActionDispatch::IntegrationTest

  setup do
    @events = create(:event)
    @events.members = create_list(:member, 5)
  end

  test "event demographic spreadsheet report" do

    sheet = load_spreadsheet "events_demographics"
    head = sheet.row(1)
    content = sheet.row(2)

    #======#
    # TODO #
    #======#

    assert_equal head[1], "Who do you live with"
    # Living Alone, Living with Partner, Living with other family member, or Other
    assert_equal head[2], "Other living arrangement"

    assert_equal head[3], "What is your marital status"
    # Single Married/civil partnered Divorced Widow Widower Prefer not to say

    assert_equal head[5], "Gender"
    # Female Male Self-definition Prefer not to say
    assert_equal head[6], "Is your gender the same as assigned at birth"
    # Yes No Prefer not to say
    assert_equal head[7], "Sexual Orientation"
    # Bisexual Gay Heterosexual Lesbian Prefer not to say

    assert_equal head[8], "How long have you lived in your ward"
    # Number in years

    assert_equal head[9], "Ethnic Background: Asian/ Asian British"
    # Indian Pakistani Bangladeshi Chinese Any other Asian/ Asian British Background (please state)
    assert_equal head[10], "Asian/ Asian British Other"
    assert_equal head[11], "Ethnic Background: Black/ Black British"
    # African Caribbean Any other Black / Black British Background (please state)
    assert_equal head[12], "Black Black British Other"
    assert_equal head[13], "Ethnic Background: White British"
    # English/NorthernIrish/Scottish/Welsh/UK Irish Gypsy/Traveller/Irish Traveller Any other white background (please state)
    assert_equal head[14], "White Other"
    assert_equal head[15], "Any Other Background"
    assert_equal head[16], "Prefer not to say"
    # Boolean

    assert_equal head[17], "Religion"
    # Christian Buddhist Hindu Jewish Muslim No religion Sikh Other Prefer not to say
    assert_equal head[18], "Other religion"

    assert_equal head[19], "Anyone Sick or disabled you care for"
    # Yes No Prefer not to say

    assert_equal head[20], "Do you have any long standing conditions"
    # bool

    assert_equal head[21], "Please name/briefly describe condition"

    assert_equal head[22], "Education level"
    # No Schooling Primary Secondary/ O-level or equivalent/ Post-14 Apprenticeship A-level or equivalent/ apprenticeship Degree level or equivalent Postrgaduate degree level or equivalent Prefer not to say
    assert_equal head[23], "Current Employment status"
    # Employed full-time Employed part-time Retired Unemployed Self-employed
    assert_equal head[24], "Postcode"

    #======#
    # DONE #
    #======#

    assert_equal head[0], "Event External ID"
    assert_equal content[0], 1

    assert_equal head[4], "What is your year of birth"
    assert_equal content[4], 1956


  end
end
