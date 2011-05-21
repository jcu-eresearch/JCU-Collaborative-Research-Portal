class CommentsController < ApplicationController

  before_filter :get_comment, :only => [:destroy]
  before_filter :get_post_from_comment, :only => [:destroy]
  before_filter :must_be_moderator, :only => [:destroy]

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def get_post_from_comment
    @post = @comment.post
  end
  
  def must_be_moderator
    if @post
      login_required_as_moderator(post_path(@post))
    else
      login_required_as_moderator
    end
  end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment])
		@comment.researcher = logged_in_researcher

		if @comment.save
			redirect_to post_path(@post), :notice => "Comment was successfully added."
		else
			redirect_to post_path(@post), :alert => "Failed to add comment: #{@comment.errors.full_messages.join(', ')}"
		end
	end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_url(@post)) }
      format.xml  { head :ok }
    end
  end
end
