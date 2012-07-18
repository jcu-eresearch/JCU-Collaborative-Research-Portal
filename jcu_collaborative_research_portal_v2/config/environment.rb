# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
JcuCollaborativeResearchPortal::Application.initialize!

require 'ldap'

LDAP_HOSTNAME = 'ldap.jcu.edu.au'
LDAP_BASE = "dc=jcu, dc=edu, dc=au"
LDAP_SEARCH_PATH = "#{LDAP_BASE}"

