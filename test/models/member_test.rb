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
end
