require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:joe)
    @group = groups(:one)
    @other_group = groups(:two)
  end

  test "should get index" do
    get :index, nil, { :jc_number => @researcher.to_param }
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new, nil, { :jc_number => @researcher.to_param }
    assert_response :success
  end

  test "should create group" do
    new_group = Group.new
    new_group.name = "MyNewGroup"
    assert_difference('Group.count') do
      post :create, { :group => new_group.attributes}, { :jc_number => @researcher.to_param }
    end


    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, { :id => @group.to_param }, { :jc_number => @researcher.to_param }
    assert_response :success
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, { :id => @group.to_param }, { :jc_number => @researcher.to_param }
    end

    assert_redirected_to groups_path
  end
end
