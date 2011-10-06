# A Researcher has:
# name::          The name of the researcher 
# jc_number::     A jc_number (the researcher's login) - must be unique, can't change
# moderator::     Whether or not the Researcher is a moderator (true/false)
# posts::         The Researcher's Posts
# address::       The Researcher's street address 
# email::         The Researcher's email address 
# title::         The Researcher's title (e.g Senior Lecturer) 
class Researcher < ActiveRecord::Base
  extend FriendlyId

  # How many researchers to show per page (for pagination)
  self.per_page = 20

  # A researcher must have a jc number, and that jc number must be unique among all researchers.
  # The jc_number can't change.
  validates :jc_number, :presence => true, :uniqueness => true
  attr_readonly :jc_number

  attr_protected :moderator

  # A Researcher must have a name.
  validates :name, :presence => true

  # Use the researcher's name the url (to_param) path to the researcher.
  friendly_id :name, :use => :slugged
  
  acts_as_taggable_on :liked_tags
  acts_as_taggable_on :disliked_tags

  
  # A researcher has an address.
  # The researcher's address is dependent on the researcher.
  # i.e. When the researcher is deleted, delete their associated address.
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address
  
  has_many :posts

  # A researcher can have a profile_image
  has_attached_file :profile_image, :default_url => "/assets/:class/:attachment/missing/missing_:style.jpg", :styles => {
    :micro => "40x40#",
    :thumb => "100x100#",
    :small => "250x250>" 
  }

  # profile image must be a recognised image 
  validates_attachment_content_type :profile_image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/pjpeg', 'image/x-png', 'image/jpeg2000'], :message => 'not a recognised image'

  # profile image must be less than 1MB 
  validates_attachment_size :profile_image, :less_than=>1.megabyte, :message => "too large, must be less than 1 megabyte in size."

  # username/password is valid
  #
  # - If this user/pass is valid:
  #   - If the user_id matches an existing researcher's user_id, 
  #     return that researcher.
  #   - If the user/pass doesn't match an existing researcher's user_id, 
  #     create a new researcher, and return it.
  # - Else, the user/pass is invalid: return false
  #
  # TODO: Hook this method into JCU's LDAP
  def self.authenticate(jc_number, pass)
    # XXX Put in temporary code to set whether the log in is valid or not based on regex
    valid = false
    valid = true if jc_number =~ /^jc\d+$/
    if valid
      researcher = Researcher.find_or_create_by_jc_number({:jc_number => jc_number, :name => jc_number})
    else
      false
    end
  end
  

  # Search the researchers.
  # search_name::     Optionally search for posts by title
  # page::            Optionally set which page you were up to - for pagination, when there is multiple pages of results
  def self.search(search_name, page)
    paginate :per_page => self.per_page, :page => page,
      :conditions => ['name like ?', "%#{search_name}%"],
      :order => 'name ASC'
  end
end
