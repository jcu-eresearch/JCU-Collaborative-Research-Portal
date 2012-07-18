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

  # Only show up to this many similar researchers
  RELATED_ITEM_LIMIT = 20 

  # Before a user is created, even before validation, attempt to prefill their user-details.
  before_create :prefill_user_details_from_ldap

  before_validation :downcase_tags
  validate :liked_tags_cant_also_be_disliked
  

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
  
  # validator to make sure that a tag isn't in both the liked and disliked list
  def liked_tags_cant_also_be_disliked
    # perform an intersection.
    unless ( both_liked_and_disliked_tags = ( liked_tag_list & disliked_tag_list ) ).empty?
      errors[:base] << ("The following tags are both liked and disliked: #{both_liked_and_disliked_tags.join(', ')}.")
    end
  end
  
  # downcase the researcher's liked and disliked tags
  def downcase_tags
    (liked_tag_list + disliked_tag_list).each do |tag|
      tag.downcase!
    end
  end

  # username/password is valid
  #
  # - If this user/pass is valid:
  #   - If the user_id matches an existing researcher's user_id, 
  #     return that researcher.
  #   - If the user/pass doesn't match an existing researcher's user_id, 
  #     create a new researcher, and return it.
  # - Else, the user/pass is invalid: return false
  def self.authenticate(jc_number, pass)
    valid = false
    begin
      # Don't proceed unless a jc_number and password were provided. Make sure neither are empty.
      if (jc_number and !jc_number.empty? and pass and !pass.empty?)
        # Create a connection to JCU's LDAP
        conn = LDAP::Conn.new(LDAP_HOSTNAME, LDAP::LDAP_PORT)
        dn = nil

        # Bind to the LDAP
        conn.bind(LDAP_BASE) do
          # Search for the user, and get their dn
          filter = "(&(uid=#{jc_number})(objectclass=jcuPerson))"
          conn.search(LDAP_BASE, LDAP::LDAP_SCOPE_SUBTREE, filter) do |entry|
            dn = entry.get_dn
          end
        end

        # If we found a dn...
        if dn
          # Attempt to bind to the LDAP using the user's password.
          # If we fail to bind, the user is invalid.
          conn.bind("#{dn}", "#{pass}") do
            valid = true
          end
        end

      end
    rescue => err
      logger.error "Error authenticating jc number against LDAP. jc_number: #{jc_number.inspect}. Error: #{err}. Backtrace: #{err.backtrace}"
      valid = false
    end

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

  def prefill_user_details_from_ldap
    logger.debug "About to prefill data for #{self.jc_number}..."

    begin
      conn = LDAP::Conn.new(LDAP_HOSTNAME, LDAP::LDAP_PORT)
      conn.bind(LDAP_BASE) do
        filter = "(&(uid=#{jc_number})(objectclass=jcuPerson))"
        conn.search(LDAP_BASE, LDAP::LDAP_SCOPE_SUBTREE, filter) do |entry|
          
          if self.name == self.jc_number
            self.name = ( entry.get_values('cn').first rescue self.jc_number ).to_s
          end

          self.email = ( entry.get_values('mail').first rescue '' ).to_s

          self.title ||= ( entry.get_values('title').join('; ') rescue '' ).to_s

          logger.debug "Prefilled user details for #{self.jc_number}: #{[name, email, title].compact.join(', ')}"
        end
      end
    rescue LDAP::ResultError => err
       logger.error "Failed to prefil user details for #{self.jc_number}. Error: #{err.inspect}"
    end
   
    true
  end
end
