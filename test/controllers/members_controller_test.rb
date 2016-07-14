require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in @user
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
                              is_resident: @member.is_resident,
                              region: @member.region,
                              ethnic_background: @member.ethnic_background,
                              ethnic_background_other: @member.ethnic_background_other,
                              email: @member.email,
                              mob: @member.mob,
                              tel: @member.tel,
                              notes: @member.notes }
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, id: @member
    assert_response :success
    assert_select ".member__name"
    assert_select ".member__dob"
    assert_select ".member__is-resident"
    assert_select ".member__region"
    assert_select ".member__ethnic-background"
    assert_select ".member__ethnic-background-other"
    assert_select ".member__email"
    assert_select ".member__mob"
    assert_select ".member__tel"
    assert_select ".member__notes"
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    patch :update, id: @member, member: { first_name: @member.first_name,
                                          last_name: @member.last_name,
                                          dob: @member.dob,
                                          is_resident: @member.is_resident,
                                          region: @member.region,
                                          ethnic_background: @member.ethnic_background,
                                          ethnic_background_other: @member.ethnic_background_other,
                                          email: @member.email,
                                          mob: @member.mob,
                                          tel: @member.tel,
                                          notes: @member.notes}
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end
end
