# Load the rails application
require File.expand_path('../application', __FILE__)

# Basic CAS client configuration
#require 'casclient'
#require 'casclient/frameworks/rails/filter'
#require 'rubycas-client'
#require 'rubycas-client-rails'


=begin
# JCU CAS Config
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://cas.secure.jcu.edu.au/cas/",
  :username_session_key => :jc_number
)
=end

# Initialize the rails application
JcuCollaborativeResearchPortal::Application.initialize!

