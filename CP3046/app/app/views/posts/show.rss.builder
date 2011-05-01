# show.rss.builder (post)
# Shows all the comments on this post
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "#{@post.title}"
		xml.description "Post #{@post.title} by #{@post.researcher.name}"
		xml.link post_url(@post, :rss)

		for comment in @post.comments
			xml.item do
				xml.title "Comment #{comment.id} by #{comment.researcher.name}"
				xml.description comment.body_as_html
				xml.pubDate comment.created_at.to_s(:rfc822)
				xml.link post_url(@post, :comment => comment.id)
				xml.guid post_url(@post, :comment => comment.id)
			end
		end
	end
end
