# Shared controller resource.
#
# Ensures users are logged in before they _hit_ route specific controllers
# 
# Provides user authentication helper methods
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '45cee7d63e12a98bccc4f673bd4068ff'
    
  helper_method :logged_in?
  helper_method :logged_in_researcher
  helper_method :login_required_as_researcher
  helper_method :login_required_as_moderator

  before_filter :login_required_as_any_researcher

  private

  # Returns true if the user is logged in to the CAS.
  # else, returns false.
  # This method is only appropriate for html format requests.
  # If the user is logged into the CAS, this method also sets the @current_researcher
  # If the user isn't logged into the CAS, this method will set the redirect paths.
  # Nothing should run after this method if the validate cas returns false.
  def validate_cas
    if CASClient::Frameworks::Rails::Filter.filter(self)
      set_logged_in_cas_user_if_logged_in
      return true
    else
      return false
    end
  end

  
  # If the user is logged into the cas, this method
  # sets the @current_researcher variable to the appropriate value
  def set_logged_in_cas_user_if_logged_in
      if jc_number = session[:cas_user]
        # If the user is auth'd set the current_researcher now.
        @current_researcher = Researcher.find_or_create_by_jc_number({:jc_number => jc_number, :name => jc_number})
      else
        nil
      end
  end

  # Check if the user is logged in as any researcher (any valid user).
  # - If the user isn't logged in as a researcher
  #   - format .html => redirects the user
  #   - format .xml/.rss => requests HTTP_BASIC_AUTH
  def login_required_as_any_researcher
    respond_to do |format|
      format.html do
        validate_cas
      end
      format.xml do   
        @current_researcher = authenticate_or_request_with_http_basic('researcher') do |login, password|
          Researcher.authenticate(login, password)
        end
      end
      format.rss do   
        @current_researcher = authenticate_or_request_with_http_basic('researcher') do |login, password|
          Researcher.authenticate(login, password)
        end
      end
    end
  end

  # Check if the user is logged in as a specific researcher.
  # - If the user isn't logged in as the specific researcher
  #   - format .html => redirects the user
  #   - format .xml/.rss => requests HTTP_BASIC_AUTH
  def login_required_as_researcher(expected_researcher, redirect_to_url=new_session_url)
    respond_to do |format|
      format.html do
        if validate_cas
          # Auth user against CAS
          if logged_in_researcher != expected_researcher
            alert = "You don't have permission to view that page"         
            redirect_to(redirect_to_url, :alert=> alert)
          end
        end
      end
      format.xml do   
        authenticate_or_request_with_http_basic("researcher_#{expected_researcher.id}") do |login, password|
          @current_researcher = Researcher.authenticate(login, password)
          @current_researcher == expected_researcher
        end
      end
      format.rss do   
        authenticate_or_request_with_http_basic("researcher_#{expected_researcher.id}") do |login, password|
          @current_researcher = Researcher.authenticate(login, password)
          @current_researcher == expected_researcher
        end
      end
    end
  end
  
  # Check if the user is logged as a user with moderator privelages.
  # - If the user isn't logged in as a moderator:
  #   - format .html => redirects the user
  #   - format .xml/.rss => requests HTTP_BASIC_AUTH
  def login_required_as_moderator(redirect_to_url=new_session_url)
    respond_to do |format|
      format.html do
        if validate_cas
          unless logged_in_researcher.moderator
            alert = "You don't have permission to view that page."
            redirect_to(redirect_to_url, :alert=> alert)
          end
        end
      end
      format.xml do   
        authenticate_or_request_with_http_basic("researcher_moderator") do |login, password|
          @current_researcher = Researcher.authenticate(login, password)
          @current_researcher.moderator
        end
      end
      format.rss do   
        authenticate_or_request_with_http_basic("researcher_moderator") do |login, password|
          @current_researcher = Researcher.authenticate(login, password)
          @current_researcher.moderator
        end
      end
    end
  end

  # The user is logged in if current_researcher is set.
  def logged_in?
    not @current_researcher.nil?
  end

  # Returns the currently logged in researcher
  #
  # Raises if there is no logged in researcher
  def logged_in_researcher
    if @current_researcher.nil?
      raise "Trying to access the logged_in_researcher when the user isn't logged in. This should not happen."
    end

    return @current_researcher
  end
end
