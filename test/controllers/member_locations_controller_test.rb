require 'test_helper'

class MemberLocationsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in @user
    @member_location = create(:member_location)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_location" do
    assert_difference('MemberLocation.count') do
      post :create, member_location: { from: @member_location.from, location_id: @member_location.location_id, member_id: @member_location.member_id, to: @member_location.to }
    end

    assert_redirected_to member_location_path(assigns(:member_location))
  end

  test "should show member_location" do
    get :show, id: @member_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member_location
    assert_response :success
  end

  test "should update member_location" do
    patch :update, id: @member_location, member_location: { from: @member_location.from, location_id: @member_location.location_id, member_id: @member_location.member_id, to: @member_location.to }
    assert_redirected_to member_location_path(assigns(:member_location))
  end

  test "should destroy member_location" do
    assert_difference('MemberLocation.count', -1) do
      delete :destroy, id: @member_location
    end

    assert_redirected_to member_locations_path
  end
end
