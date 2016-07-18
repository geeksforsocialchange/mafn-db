require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = create(:project)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: {  name: @project.name,
                                primary_partner_organisation_id: @project.primary_partner_organisation_id,
                                resident_champion_id: @project.resident_champion_id,
                                resident_seconder_id: @project.resident_seconder_id,
                                start: @project.start,
                                finish: @project.finish,
                                region: @project.region
                              }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { name: @project.name,
                                            primary_partner_organisation_id: @project.primary_partner_organisation_id,
                                            resident_champion_id: @project.resident_champion_id,
                                            resident_seconder_id: @project.resident_seconder_id,
                                            start: @project.start,
                                            finish: @project.finish, 
                                            region: @project.region
                                          }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
