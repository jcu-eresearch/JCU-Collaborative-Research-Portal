# A Post has a:
# researcher::              The Researcher who made the post
# comments::                The Comments made on this post
# title::                   The Post has a title
# content::                 The content of the post (Markdown)
# tags::                    The Post can be tagged (acts_as_taggable)
class Post < ActiveRecord::Base
  extend FriendlyId
  
  RELATED_ITEM_LIMIT = 20 # Only show up to this many similar researchers

  # How many posts to show per page (for pagination)
  self.per_page = 20
            
  belongs_to :researcher
  validates :researcher, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true
  has_many :comments, :dependent => :destroy

  acts_as_taggable
  
  before_validation :downcase_tags

  # Use the title of the post as the url (to_param) path to the post.
  friendly_id :title, :use => :slugged

  
  # Return the content converted from markdown, to html.
  def content_as_html
    BlueCloth.new(content).to_html
  end

  def downcase_tags
    tag_list.each do |tag|
      tag.downcase!
    end
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
