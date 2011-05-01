# index.rss.builder (posts)
# Show all the research posts by all researchers
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "Posts"
		xml.description "All Posts"
		xml.link posts_url :rss

		for post in @posts
			xml.item do
				xml.title "#{post.title} by #{post.researcher.name}"
				xml.description post.content_as_html
				xml.pubDate post.created_at.to_s(:rfc822)
				xml.link post_url(post)
				xml.guid post_url(post)
			end
		end
	end
end
