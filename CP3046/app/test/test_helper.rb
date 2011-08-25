ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # verbatim, from ActiveController's own unit tests
  def encode_credentials(username, password)
    "Basic #{ActiveSupport::Base64.encode64("#{username}:#{password}")}"
  end


  # Methods to help test CAS redirects, etc.
  def assert_redirected_to_login(redirect_destination=nil)
    assert_response :redirect 
    assert_match(/#{CASClient::Frameworks::Rails::Filter.config[:login_url]}/,redirect_to_url) 
  end 

  def stub_cas_logged_in(user) 
    unstub_cas 
    CASClient::Frameworks::Rails::Filter.singleton_class.send :define_method, :filter do |controller| 
      controller.session[:cas_user] = user.cas_username 
      controller.session[:user] = user.id 
      true 
    end 
  end 

  def stub_cas_logged_out 
    unstub_cas 
    CASClient::Frameworks::Rails::Filter.singleton_class.send :define_method, :filter do |controller| 
      controller.send(:redirect_to, 'access/denied') 
      controller.send(:reset_session) 
      false 
    end 
  end 

  def unstub_cas 
    CASClient::Frameworks::Rails::Filter.singleton_class.class_eval do 
      if self.respond_to?(:original_filter) 
        alias :filter :original_filter 
        undef :original_filter 
      end 
    end 

    CASClient::Frameworks::Rails::Filter.singleton_class.class_eval do 
      alias :original_filter :filter 
    end 
  end 
end
