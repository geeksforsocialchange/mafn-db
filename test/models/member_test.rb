require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  setup do
    @member = build(:member)
  end

  test "is valid" do
    assert @member.valid?
  end

  test "gets assigned entity id after being saved" do
    @member.save
    assert @member.entity_id
  end

  test "return age as a year" do
    assert_equal @member.age, 60
  end

  test "return correct shortcodes for region" do
    @member.region = 0
    assert_equal @member.region_code, "HM"
    @member.region = 1
    assert_equal @member.region_code, "BU"
    @member.region = 2
    assert_equal @member.region_code, "MO"
  end

  test "return correct initials" do
    assert_equal @member.initials, "JD"
  end

  test "return correct full name" do
    assert_equal @member.full_name, "Doe, Jane"
  end

  test "returns a correct membership number" do
    # Default member is Jane Doe, Hulme and Moss Side, ID 1
    @fixed_id_member = build(:member, id: 1)
    assert_equal @fixed_id_member.membership_code, "AFN-HM-0001-JD"
  end

  test "return correct ethnicity export array" do
    # Asian options
    # "Bangladeshi": 0, "Chinese": 1, "Indian": 2, "Pakistani": 3, "Any other Asian/ Asian British Background (please state)": 4,
    @bangladeshi = build(:complete_member, ethnic_background: 0)
    assert_equal @bangladeshi.export_ethnicity, ["Bangladeshi", "", "", "", "", "", "", ""]

    @chinese = build(:complete_member, ethnic_background: 1)
    assert_equal @chinese.export_ethnicity, ["Chinese", "", "", "", "", "", "", ""]

    @indian = build(:complete_member, ethnic_background: 2)
    assert_equal @indian.export_ethnicity, ["Indian", "", "", "", "", "", "", ""]

    @pakistani = build(:complete_member, ethnic_background: 3)
    assert_equal @pakistani.export_ethnicity, ["Pakistani", "", "", "", "", "", "", ""]

    @asian_other = build(:complete_member, ethnic_background: 4)
    assert_equal @asian_other.export_ethnicity, ["Any other Asian/ Asian British Background (please state)", "Another ethnic background", "", "", "", "", "", ""]

    ## Black options
    # "African": 5, "Caribbean": 6, "Any other Black / Black British Background (please state)": 7,
    @african = build(:complete_member, ethnic_background: 5)
    assert_equal @african.export_ethnicity, ["", "", "African", "", "", "", "", ""]

    @caribean = build(:complete_member, ethnic_background: 6)
    assert_equal @caribean.export_ethnicity, ["", "", "Caribbean", "", "", "", "", ""]

    @black_other = build(:complete_member, ethnic_background: 7)
    assert_equal @black_other.export_ethnicity, ["", "", "Any other Black / Black British Background (please state)", "Another ethnic background", "", "", "", ""]

    ## White options
    # "English/Northern Irish/Scottish/Welsh": 8, "Irish": 9, "Gypsy/Traveller/Irish Traveller": 10, "Any other white background (please state)": 11,
    @english = build(:complete_member, ethnic_background: 8)
    assert_equal @english.export_ethnicity, ["", "", "", "", "English/Northern Irish/Scottish/Welsh", "", "", ""]

    @irish = build(:complete_member, ethnic_background: 9)
    assert_equal @irish.export_ethnicity, ["", "", "", "", "Irish", "", "", ""]

    @gypsy = build(:complete_member, ethnic_background: 10)
    assert_equal @gypsy.export_ethnicity, ["", "", "", "", "Gypsy/Traveller/Irish Traveller", "", "", ""]

    @white_other = build(:complete_member, ethnic_background: 11)
    assert_equal @white_other.export_ethnicity, ["", "", "", "", "Any other white background (please state)", "Another ethnic background", "", ""]


    # "Any other background": 12, "Any mixed background": 13
    @other = build(:complete_member, ethnic_background: 12)
    assert_equal @other.export_ethnicity, ["", "", "", "", "", "", "Another ethnic background", ""]

    @mixed = build(:complete_member, ethnic_background: 13)
    assert_equal @mixed.export_ethnicity, ["", "", "", "", "", "", "", "Another ethnic background"]


  end
end
