require 'test_helper'

class ApplicationLayoutTestTest < ActionDispatch::IntegrationTest

  test "navigation links" do
    get root_path
    assert_select '.nav a[href=?]', '/members'
    assert_select '.nav a[href=?]', '/events'
    assert_select '.nav a[href=?]', '/locations'
    assert_select '.nav a[href=?]', '/member_locations'
    assert_select '.nav a[href=?]', '/questions'
    assert_select '.nav a[href=?]', '/question_responses'
    assert_select '.nav a[href=?]', '/question_sets'
    assert_select '.nav a[href=?]', '/exports'
  end
end