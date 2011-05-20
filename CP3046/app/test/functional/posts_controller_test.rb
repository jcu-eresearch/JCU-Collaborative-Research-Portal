require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:joe)
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
  
  test "shouldn't show post (rss) without http_auth provided" do
    get :show, { :format => 'rss', :id => @post.to_param }, { :jc_number => @researcher.to_param }
    assert_response :unauthorized
  end

  test "should show post (rss) with http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@researcher.jc_number, 'pass')
    get :show, { :format => 'rss', :id => @post.to_param }
    assert_response :success
  end
  
  test "shouldn't show post (rss) with bad http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials('foo', 'bar')
    get :show, { :format => 'rss', :id => @post.to_param }
    assert_response :unauthorized
  end
end
