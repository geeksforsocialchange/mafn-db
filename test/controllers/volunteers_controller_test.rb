require 'test_helper'

class VolunteersControllerTest < ActionController::TestCase
  setup do
    @volunteer = create(:volunteer)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:volunteers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create volunteer" do
    assert_difference('Volunteer.count') do
      post :create, volunteer: { finish: @volunteer.finish, is_leader: @volunteer.is_leader, member_id: @volunteer.member_id, project_id: @volunteer.project_id, role: @volunteer.role, start: @volunteer.start }
    end

    assert_redirected_to volunteer_path(assigns(:volunteer))
  end

  test "should show volunteer" do
    get :show, id: @volunteer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @volunteer
    assert_response :success
  end

  test "should update volunteer" do
    patch :update, id: @volunteer, volunteer: { finish: @volunteer.finish, is_leader: @volunteer.is_leader, member_id: @volunteer.member_id, project_id: @volunteer.project_id, role: @volunteer.role, start: @volunteer.start }
    assert_redirected_to volunteer_path(assigns(:volunteer))
  end

  test "should destroy volunteer" do
    assert_difference('Volunteer.count', -1) do
      delete :destroy, id: @volunteer
    end

    assert_redirected_to volunteers_path
  end
end
