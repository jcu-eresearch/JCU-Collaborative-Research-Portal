class Researcher < ActiveRecord::Base
	# A researcher must have a jc number, and that jc number must be unique among all researchers.
	validates :jc_number, :presence => true, :uniqueness => true
	attr_readonly :jc_number
	
	# A researcher has an address.
	# The researcher's address is dependent on the researcher.
	# i.e. When the researcher is deleted, delete their associated address
	has_one :address, :as => :addressable, :dependent => :destroy
	has_many :post
	accepts_nested_attributes_for :address

	# TODO: 
	# At this point, we need to check against the ldap to see if this username/password is valid
	#
	# If this user/pass is valid:
	# 	If the user_id matches an existing researcher's user_id, return that researcher.
	# 	If the user/pass doesn't match an existing researcher's user_id, create a new researcher, and return it.
	# Else, the user/pass is invalid: return false
	def self.authenticate(jc_number, pass)
		# XXX Put in temporary code to randomly set whether the log in is valid
		valid = false
		rand_number = 1 + rand(6)
		valid = true if rand_number > 3
		if valid
			Researcher.find_or_create_by_jc_number(jc_number)
		else
			false
		end
	end
end
