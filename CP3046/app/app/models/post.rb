class Post < ActiveRecord::Base
            
	belongs_to :researcher
	validates :researcher, :presence => true
	validates :title, :presence => true
	validates :content, :presence => true
	has_many :comments
  
  acts_as_taggable
  acts_as_taggable_on :tags
  
  has_friendly_id :title, :use_slug => true

	def content_as_html
	 	BlueCloth.new(content).to_html
	end

	def self.per_page
		20
	end

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
