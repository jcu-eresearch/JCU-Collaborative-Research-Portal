class Researcher < ActiveRecord::Base
	validates :name, :presence => true
	
	# A researcher has an address.
	# The researcher's address is dependent on the researcher.
	# i.e. When the researcher is deleted, delete their associated address
	has_one :address, :as => :addressable, :dependent => :destroy
	accepts_nested_attributes_for :address

end
