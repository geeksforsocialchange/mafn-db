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

  test "returns correct shortcodes for region" do
    @member.region = 0
    assert_equal @member.region_code, "HM"
    @member.region = 1
    assert_equal @member.region_code, "BU"
    @member.region = 2
    assert_equal @member.region_code, "MO"
  end

  test "returns correct initials" do
    assert_equal @member.initials, "JD"
  end

  test "returns correct full name" do
    assert_equal @member.full_name, "Doe, Jane"
  end

  test "returns a correct membership number" do
    # Default member is Jane Doe, Hulme and Moss Side, ID 1
    @fixed_id_member = build(:member, id: 1)
    assert_equal @fixed_id_member.membership_code, "AFN-HM-0001-JD"
  end
end
