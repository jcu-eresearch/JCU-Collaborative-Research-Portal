require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:joe)
    @moderator = researchers(:moderator)
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

  test "moderator should delete post with http_auth provided (via xml)" do
    assert_difference('Post.count', -1) do
      @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@moderator.jc_number, 'pass')
      delete :destroy, { :format => 'xml', :id => @post.to_param }
    end
    assert_response :success
  end
  
  test "shouldn't delete post as not logged in"  do
    delete :destroy, { :id => @post.to_param }
    assert_redirected_to_login(post_path(@path))
  end

  test "shouldn't delete post (xml) with bad http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials('foo', 'bar')
    delete :destroy, { :format => 'xml', :id => @post.to_param }
    assert_response :unauthorized
  end
  
  test "moderator (researcher) should delete post with session info provided" do
    assert_difference('Post.count', -1) do
      delete :destroy, { :id => @post.to_param }, { :jc_number => @moderator.to_param }
    end
    assert_redirected_to posts_path
  end
  
  test "non-moderator (researcher) shouldn't delete post with http_auth provided (via xml)" do
    assert_difference('Post.count', 0) do
      @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@researcher.jc_number, 'pass')
      delete :destroy, { :format => 'xml', :id => @post.to_param }
    end
    assert_response :unauthorized
  end
  
  test "non-moderator (researcher) shouldn't delete post with session info provided" do
    assert_difference('Post.count', 0) do
      delete :destroy, { :id => @post.to_param }, { :jc_number => @researcher.to_param }
    end
    assert_redirected_to post_path(@post)
  end
end
