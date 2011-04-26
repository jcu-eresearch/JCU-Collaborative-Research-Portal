class Post < ActiveRecord::Base
	belongs_to :researcher
	validates :researcher, :presence => true
	has_many :comments
end
