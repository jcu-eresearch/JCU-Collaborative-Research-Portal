require 'test_helper'

class ResearchersControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:researchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create researcher" do
    assert_difference('Researcher.count') do
      post :create, researcher: @researcher.attributes
    end

    assert_redirected_to researcher_path(assigns(:researcher))
  end

  test "should show researcher" do
    get :show, id: @researcher.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @researcher.to_param
    assert_response :success
  end

  test "should update researcher" do
    put :update, id: @researcher.to_param, researcher: @researcher.attributes
    assert_redirected_to researcher_path(assigns(:researcher))
  end

  test "should destroy researcher" do
    assert_difference('Researcher.count', -1) do
      delete :destroy, id: @researcher.to_param
    end

    assert_redirected_to researchers_path
  end
end
