require 'test_helper'

class QuestionListsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in @user
    @question_list = create(:question_list)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_list" do
    assert_difference('QuestionList.count') do
      post :create, question_list: { question_id: @question_list.question_id, question_set_id: @question_list.question_set_id, weight: @question_list.weight }
    end

    assert_redirected_to question_list_path(assigns(:question_list))
  end

  test "should show question_list" do
    get :show, id: @question_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_list
    assert_response :success
  end

  test "should update question_list" do
    patch :update, id: @question_list, question_list: { question_id: @question_list.question_id, question_set_id: @question_list.question_set_id, weight: @question_list.weight }
    assert_redirected_to question_list_path(assigns(:question_list))
  end

  test "should destroy question_list" do
    assert_difference('QuestionList.count', -1) do
      delete :destroy, id: @question_list
    end

    assert_redirected_to question_lists_path
  end
end
