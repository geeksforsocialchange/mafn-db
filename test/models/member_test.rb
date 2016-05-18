require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  setup do
    @member = build(:member)
  end

  test "is valid" do
    assert @member.valid?
  end

end
