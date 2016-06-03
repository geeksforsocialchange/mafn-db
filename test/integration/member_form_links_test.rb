require 'test_helper'

class MemberFormLinksTest < ActionDispatch::IntegrationTest
  setup do
    @member = create(:member)
    @response = create(:question_response)
    @member.question_responses << @response
  end

  test "member tasks related to answering questions" do
    get member_path(@member)
    assert_select "dl.question-responses"
    assert_select "dt", "Is there anything specific preventing you from taking part which you would like to change?"
    assert_select "dd a", "I struggle with mobility issues getting into some of the venues"
  end
end
