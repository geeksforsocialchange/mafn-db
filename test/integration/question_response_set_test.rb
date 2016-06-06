require 'test_helper'

class QuestionResponseSetTest < ActionDispatch::IntegrationTest
  setup do
    @member = create(:member)
    @question_set = create(:question_set)
  end

  test "should show question set page if no member param given" do
    get respond_question_set_path(@question_set)
    assert_response :success
  end

end
