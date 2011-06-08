# A Post has a:
# researcher::              The Researcher who made the post
# comments::                The Comments made on this post
# title::                   The Post has a title
# content::                 The content of the post (Markdown)
# tags::                    The Post can be tagged (acts_as_taggable)
class Post < ActiveRecord::Base
            
  belongs_to :researcher
  validates :researcher, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true
  has_many :comments, :dependent => :destroy
  
  acts_as_taggable
  acts_as_taggable_on :tags
  
  # Use the title of the post as the url (to_param) path to the post.
  has_friendly_id :title, :use_slug => true

  
  # Return the content converted from markdown, to html.
  def content_as_html
    BlueCloth.new(content).to_html
  end

  # How many posts to show per page (for pagination)
  def self.per_page
    20
  end

  # Search the posts.
  # search_title::    Optionally search for posts by title
  # search_tags::     Optionally search for posts by tag 
  # page::            Optionally set which page you were up to - for pagination, when there is multiple pages of results
  def self.search(search_title, search_tags, page)
    if search_tags and !search_tags.strip.empty?
      search_tags.strip!
      tagged_with(search_tags).paginate :per_page => self.per_page, :page => page,
        :conditions => ['title like ?', "%#{search_title}%"]
    else
      paginate :per_page => self.per_page, :page => page,
        :conditions => ['title like ?', "%#{search_title}%"]
    end
  end
end
