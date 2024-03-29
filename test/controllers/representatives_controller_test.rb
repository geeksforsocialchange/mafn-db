require 'test_helper'

class RepresentativesControllerTest < ActionController::TestCase
  setup do
    @representative = create(:representative)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:representatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create representative" do
    assert_difference('Representative.count') do
      post :create, representative: { finish: @representative.finish, job_title: @representative.job_title, member_id: @representative.member_id, organisation_id: @representative.organisation_id, start: @representative.start }
    end

    assert_redirected_to representative_path(assigns(:representative))
  end

  test "should show representative" do
    get :show, id: @representative
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @representative
    assert_response :success
  end

  test "should update representative" do
    patch :update, id: @representative, representative: { finish: @representative.finish, job_title: @representative.job_title, member_id: @representative.member_id, organisation_id: @representative.organisation_id, start: @representative.start }
    assert_redirected_to representative_path(assigns(:representative))
  end

  test "should destroy representative" do
    assert_difference('Representative.count', -1) do
      delete :destroy, id: @representative
    end

    assert_redirected_to representatives_path
  end
end
