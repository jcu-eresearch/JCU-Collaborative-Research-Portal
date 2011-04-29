# account.rss.builder
# Shows the personal feed for the user.
# This is the rss feed of all the posts relevant to the user
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "#{@researcher.name} - Personal Feed"
		xml.description "#{@researcher.name} - Personal Feed - Protected"
		xml.link researcher_url(@researcher, :rss)

		for post in @researcher.posts
			xml.item do
				xml.title post.title
				xml.description post.content
				xml.pubDate post.created_at.to_s(:rfc822)
				xml.link post_url(post)
				xml.guid post_url(post)
			end
		end
	end
end
