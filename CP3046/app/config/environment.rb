# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
App::Application.initialize!

# Basic CAS client configuration

require 'casclient'
require 'casclient/frameworks/rails/filter'

# JCU CAS Config
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://cas.secure.jcu.edu.au/cas/"
)
