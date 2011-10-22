# account.rss.builder
# Shows the personal feed for the user.
# This is the rss feed of all the posts relevant to the user
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "#{@researcher.name} - Personal Feed"
		xml.description "#{@researcher.name} - Personal Feed - Protected"
		xml.link account_researcher_url(@researcher, :rss)

		for post in Post.all
      # Always show a post if you have liked one of its tags.
      # Show any post which doesn't have a tag that you have specifically disliked.
      if ( (@researcher.liked_tag_list & post.tag_list).any? or (@researcher.disliked_tag_list & post.tag_list).empty? )
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
end
