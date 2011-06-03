class CommentsController < ApplicationController

  before_filter :get_comment, :only => [:destroy]
  before_filter :get_post_from_comment, :only => [:destroy]

  # Only allow a moderator to destory a comment
  before_filter :must_be_moderator, :only => [:destroy]

  # Get the comment from params
  def get_comment
    @comment = Comment.find(params[:id])
  end

  # Get the post from the comment (the post the comment is/was made on)
  def get_post_from_comment
    @post = @comment.post
  end
  
  # Validates the user as a moderator.
  # Selects appropriate redirect path based on current page.
  def must_be_moderator
    if @post
      login_required_as_moderator(post_path(@post))
    else
      login_required_as_moderator
    end
  end

  # POST /post/post_id/comments
  # POST /post/post_id/comments.xml
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.researcher = logged_in_researcher

    if @comment.save
      format.html { redirect_to post_path(@post), :notice => "Comment was successfully added." }
      format.xml  { render :xml => @comment, :status => :created, :location => @comment}
    else
      format.html { redirect_to post_path(@post), :alert => "Failed to add comment: #{@comment.errors.full_messages.join(', ')}" }
      format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
    end
  end

  # DELETE /post/post_id/comments/1
  # DELETE /post/post_id/comments/1.xml
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_url(@post)) }
      format.xml  { head :ok }
    end
  end
end
