require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not save post without title" do
    post = Post.new
	assert !post.save
  end

  test "should not save post without researcher" do
    post = Post.new
	post.title = "a"
	assert !post.save
  end
end
