class Post < ActiveRecord::Base
	belongs_to :researcher
	validates :researcher, :presence => true
	validates :title, :presence => true
	validates :content, :presence => true
	has_many :comments

	def content_as_html
	 	BlueCloth.new(content).to_html
	end

	def self.per_page
		20
	end

	def self.search(search, page)
		paginate :per_page => self.per_page, :page => page,
			:conditions => ['title like ?', "%#{search}%"],
			:order => 'updated_at DESC'
	end
end
