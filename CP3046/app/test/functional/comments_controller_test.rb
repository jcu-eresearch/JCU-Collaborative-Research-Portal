require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @researcher = researchers(:joe)
    @moderator = researchers(:moderator)
    @comment = comments(:one)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, { :post_id => @comment.post.to_param, :comment => @comment.attributes}, { :jc_number => @researcher.to_param }
    end
    assert_redirected_to post_path(assigns(:post))
  end

  test "moderator should delete comment with http_auth provided (via xml)" do
    assert_difference('Comment.count', -1) do
      @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@moderator.jc_number, 'pass')
      delete :destroy, { :format => 'xml', :post_id => @comment.post.to_param, :id => @comment.to_param }
    end
    assert_response :success
  end
  
  test "moderator (researcher) should delete comment with session info provided" do
    assert_difference('Comment.count', -1) do
      delete :destroy, { :post_id => @comment.post.to_param, :id => @comment.to_param }, { :jc_number => @moderator.to_param }
    end
    assert_redirected_to post_path(@comment.post)
  end
  
  test "non-moderator (researcher) shouldn't delete comment with http_auth provided (via xml)" do
    assert_difference('Comment.count', 0) do
      @request.env['HTTP_AUTHORIZATION'] = encode_credentials(@researcher.jc_number, 'pass')
      delete :destroy, { :format => 'xml', :post_id => @comment.post.to_param, :id => @comment.to_param }
    end
    assert_response :unauthorized
  end
  
  test "non-moderator (researcher) shouldn't delete comment with session info provided" do
    assert_difference('Comment.count', 0) do
      delete :destroy, { :post_id => @comment.to_param, :id => @comment.to_param }, { :jc_number => @researcher.to_param }
    end
    assert_redirected_to post_path(@comment.post)
  end
end
