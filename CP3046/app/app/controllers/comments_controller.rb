class CommentsController < ApplicationController

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

end
