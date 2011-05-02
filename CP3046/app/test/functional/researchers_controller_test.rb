require 'test_helper'

class ResearchersControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:one)
    @other_researcher = researchers(:two)
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
  
  test "shouldn't show posts (rss) without http_auth provided" do
    get :posts, { :format => 'rss', :id => @researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_response :unauthorized
  end

  test "should show posts (rss) with http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@researcher.jc_number, 'one')
    get :posts, { :format => 'rss', :id => @researcher.to_param }
    assert_response :success
  end
  
  test "should show posts (rss) with other researchers http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@researcher.jc_number, 'bar')
    get :posts, { :format => 'rss', :id => @other_researcher.to_param }
    assert_response :success
  end
  
  test "shouldn't show posts (rss) with bad http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials('foo', 'bar')
    get :posts, { :format => 'rss', :id => @other_researcher.to_param }
    assert_response :unauthorized
  end

  test "should get researcher's account" do
    get :account, { :id => @researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_response :success
  end
  
  test "should not get other researcher's account" do
    get :account, { :id => @other_researcher.to_param }, { :jc_number => @researcher.to_param }
	assert_redirected_to researcher_path(@other_researcher)
  end
  
  test "shouldn't show account (rss) without http_auth provided" do
    get :account, { :format => 'rss', :id => @researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_response :unauthorized
  end

  test "should show account (rss) with http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@researcher.jc_number, 'one')
    get :account, { :format => 'rss', :id => @researcher.to_param }
    assert_response :success
  end
  
  test "shouldn't show account (rss) with other researchers http_auth provided"  do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@researcher.jc_number, 'bar')
    get :account, { :format => 'rss', :id => @other_researcher.to_param }
    assert_response :unauthorized
  end

  test "should get edit" do
    get :edit, { :id => @researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_response :success
  end
  
  test "should get posts" do
    get :posts, { :id => @researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_response :success
  end
  
  test "should not get edit as not logged in" do
    get :edit, { :id => @researcher.to_param }
    assert_redirected_to new_session_path
  end

  test "should not get edit as logged in as different researcher" do
    get :edit, { :id => @other_researcher.to_param }, { :jc_number => @researcher.to_param }
    assert_redirected_to researcher_path(@other_researcher)
  end

  test "should update researcher" do
    put :update, { :id => @researcher.to_param, :researcher => @researcher.attributes }, { :jc_number => @researcher.to_param }

    assert_redirected_to researcher_path(assigns(:researcher))
  end

end
