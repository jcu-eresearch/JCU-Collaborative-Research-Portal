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
  
  test "should save post with a title, content and a researcher" do
    researcher = researchers(:joe)
    post = Post.new
    post.title = 'This is the title'
    post.content = 'Some content'
    post.researcher = researcher
    assert post.save
  end
  
  test "should have a friendly_id of title" do
    researcher = researchers(:joe)
    post = Post.new
    post.title = 'This is the title'
    post.content = 'Some content'
    post.researcher = researcher
    assert post.save
    assert_equal 'this-is-the-title', post.to_param
  end
end
