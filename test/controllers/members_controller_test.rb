require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = create(:member)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, member: { first_name: @member.first_name,
                              last_name: @member.last_name,
                              dob: @member.dob,
                              email: @member.email,
                              gender: @member.gender,
                              mob: @member.mob,
                              tel: @member.tel }
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, id: @member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    patch :update, id: @member, member: { first_name: @member.first_name,
                                          last_name: @member.last_name,
                                          dob: @member.dob,
                                          email: @member.email,
                                          gender: @member.gender,
                                          mob: @member.mob,
                                          tel: @member.tel }
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end
end
