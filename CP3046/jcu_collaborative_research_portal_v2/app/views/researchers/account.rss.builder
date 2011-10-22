# account.rss.builder
# Shows the personal feed for the user.
# This is the rss feed of all the posts relevant to the user
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "#{@researcher.name} - Personal Feed"
		xml.description "#{@researcher.name} - Personal Feed - Protected"
		xml.link account_researcher_url(@researcher, :rss)

    @display_posts.each_pair do |post, comments|
      xml.item do
        xml.title post.title
        xml.description post.content_as_html
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end

      comments.each_with_index do |comment, i|
        comment_no = i+1
        xml.item do
          xml.title "Comment (#{comment_no}) by #{comment.researcher.name} on post #{post.title}"
          xml.description comment.body_as_html
          xml.pubDate comment.created_at.to_s(:rfc822)
          xml.link post_url(post, :anchor => comment.id)
          xml.guid post_url(post, :anchor => comment.id)
        end # end comment
      end # end comments on post

    end # end post

	end # end channel
end # end xml
