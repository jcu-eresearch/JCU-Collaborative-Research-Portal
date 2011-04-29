require 'test_helper'

class ResearchersControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:one)
  end

  test "should get index" do
    get :index, nil, { :jc_number => @researcher.to_param }
    assert_response :success
    assert_not_nil assigns(:researchers)
  end

  test "should show researcher" do
    get :show, { :id => @researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { :id => @researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_response :success
  end
  
  test "should not get edit as not logged in" do
    get :edit, { :id => @researcher.to_param }
	assert_redirected_to new_session_path
  end

  test "should update researcher" do
	Rails::logger.debug "Before"
	Rails::logger.debug @researcher.attributes.inspect
    put :update, { :id => @researcher.to_param, :researcher => @researcher.attributes }, { :jc_number => @researcher.to_param }
	Rails::logger.debug "After"

    assert_redirected_to researcher_path(assigns(:researcher))
  end

end
