require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:one)
    @post = posts(:one)
  end

  test "should get index" do
    get :index, nil, { :jc_number => @researcher.to_param }
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new, nil, { :jc_number => @researcher.to_param }
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, { :post => @post.attributes}, { :jc_number => @researcher.to_param }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, { :id => @post.to_param }, { :jc_number => @researcher.to_param }
    assert_response :success
  end

end
