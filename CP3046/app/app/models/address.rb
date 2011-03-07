class Address < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true
	validates :postcode, :numericality => true, :length => { :minimum => 4 }

	def to_s
		attributes.inspect
	end
end
