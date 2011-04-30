# show.rss.builder (researcher)
# Shows all the posts by the researcher.
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "#{@researcher.name} - Researcher Posts"
		xml.description "Research posted by #{@researcher.name}"
		xml.link researcher_url(@researcher, :rss)

		for post in @researcher.posts
			xml.item do
				xml.title post.title
				xml.description post.content_as_html
				xml.pubDate post.created_at.to_s(:rfc822)
				xml.link post_url(post)
				xml.guid post_url(post)
			end
		end
	end
end
