require 'test_helper'

class AttendancesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in @user
    @attendance = create(:attendance)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendance" do
    attendance = build(:attendance)
    assert_difference('Attendance.count') do
      post :create, attendance: { event_id: attendance.event_id, member_id: attendance.member_id }
    end

    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should show attendance" do
    get :show, id: @attendance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attendance
    assert_response :success
  end

  test "should update attendance" do
    patch :update, id: @attendance, attendance: { event_id: @attendance.event_id, member_id: @attendance.member_id }
    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should destroy attendance" do
    assert_difference('Attendance.count', -1) do
      delete :destroy, id: @attendance
    end

    assert_redirected_to attendances_path
  end
end
