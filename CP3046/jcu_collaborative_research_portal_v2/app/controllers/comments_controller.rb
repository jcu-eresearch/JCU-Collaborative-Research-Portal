class CommentsController < ApplicationController
  before_filter :get_comment, :only => [:destroy]
  before_filter :get_post_from_comment, :only => [:destroy]

  # Only allow a moderator to destory a comment
  before_filter :must_be_moderator_or_commentor, :only => [:destroy]

  # Get the comment from params
  def get_comment
    @comment = Comment.find(params[:id])
  end

  # Get the post from the comment (the post the comment is/was made on)
  def get_post_from_comment
    @post = @comment.post
  end
  
  # Validates the user as either a moderator or the owner of the comment.
  def must_be_moderator_or_commentor
    login_required_as_moderator_or_researcher(post_path(@post), @comment.researcher)
  end


  # POST /post/post_id/comments
  # POST /post/post_id/comments.xml
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.researcher = logged_in_researcher

    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@post), :notice => "Comment was successfully added." }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment}
        format.json { render :json=> @comment, :status => :created, :location => @comment}
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), :alert => "Failed to add comment: #{@comment.errors.full_messages.join(', ')}" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        format.json { render :json=> @comment.errors, :status => :unprocessable_entity }
      end 
    end
  end

  # DELETE /post/post_id/comments/1
  # DELETE /post/post_id/comments/1.xml
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_url(@post)) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end
