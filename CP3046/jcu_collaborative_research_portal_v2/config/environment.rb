# Load the rails application
require File.expand_path('../application', __FILE__)

# Basic CAS client configuration
require 'casclient'
require 'casclient/frameworks/rails/filter'

# JCU CAS Config
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://cas.secure.jcu.edu.au/cas/",
  :username_session_key => :jc_number
)

# Initialize the rails application
JcuCollaborativeResearchPortal::Application.initialize!

