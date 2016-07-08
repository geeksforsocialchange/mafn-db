require 'test_helper'

class ArrangersControllerTest < ActionController::TestCase
  setup do
    @arranger = create(:arranger)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arrangers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arranger" do
    assert_difference('Arranger.count') do
      post :create, arranger: { event_id: @arranger.event_id, project_id: @arranger.project_id }
    end

    assert_redirected_to arranger_path(assigns(:arranger))
  end

  test "should show arranger" do
    get :show, id: @arranger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @arranger
    assert_response :success
  end

  test "should update arranger" do
    patch :update, id: @arranger, arranger: { event_id: @arranger.event_id, project_id: @arranger.project_id }
    assert_redirected_to arranger_path(assigns(:arranger))
  end

  test "should destroy arranger" do
    assert_difference('Arranger.count', -1) do
      delete :destroy, id: @arranger
    end

    assert_redirected_to arrangers_path
  end
end
