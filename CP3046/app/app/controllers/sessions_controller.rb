# Logs in and out users for HTML interaction
#
# If session/create validates a user, the user info
# is storred in the HTML session.
class SessionsController < ApplicationController

  # Don't require the user to have logged in.
  before_filter CASClient::Frameworks::Rails::GatewayFilter
  skip_before_filter :login_required_as_any_researcher
  before_filter :set_logged_in_cas_user_if_logged_in

  
  # GET /session/new
  def new
    set_logged_in_cas_user_if_logged_in
    if logged_in?
      # If the user is already logged in,
      # welcome the user, and redirect them to their account page.
      notice = "Welcome #{logged_in_researcher.name}"
      redirect_to(account_researcher_path(logged_in_researcher), :notice => notice)
    else
      # If the user isn't logged in, redirect them to the login page for the cas 
      CASClient::Frameworks::Rails::Filter.redirect_to_cas_for_authentication(self)
    end
  end

  # DELETE /session/1
  def destroy
    if logged_in?
      # Log the user out of the CAS
      CASClient::Frameworks::Rails::Filter.logout(self)
    else
      alert = "You are already logged out"         
      redirect_to(homes_path, :alert=> alert)
    end
  end
end
