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

  # Check if the user is logged in as any researcher (any valid user).
  # - If the user isn't logged in as a researcher
  #   - format .html => redirects the user
  #   - format .xml/.rss => requests HTTP_BASIC_AUTH
  def login_required_as_any_researcher
    respond_to do |format|
      format.html do
        unless logged_in?
          notice = "Please log in"         
          redirect_to new_session_url(:forward_to => request.fullpath), :notice => notice
        end
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
        if logged_in?
          if logged_in_researcher != expected_researcher
            alert = "You don't have permission to view that page"         
            redirect_to(redirect_to_url, :alert=> alert)
          end
        else
          notice = "Please log in"         
          redirect_to new_session_url(:forward_to => request.fullpath), :notice => notice
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
        if logged_in?
          unless logged_in_researcher.moderator
            alert = "You don't have permission to view that page."
            redirect_to(redirect_to_url, :alert=> alert)
          end
        else
          notice = "Please log in"         
          redirect_to new_session_url(:forward_to => request.fullpath), :notice => notice
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

  # Returns true if the user is logged in, returns false otherwise
  #
  # Session specific, can't be used for HTTP_BASIC_AUTH checks
  def logged_in?
    session_id = session[:jc_number]
    if session_id
      begin
        @current_researcher = Researcher.find(session_id)
        if @current_researcher
          return true
        else
          session[:jc_number] = nil
          return false
        end
      rescue
        session[:jc_number] = nil
        return false
      end
    else
      return false
    end
  end

  # Returns the currently logged in researcher
  #
  # Raises if there is no logged in researcher
  def logged_in_researcher
    # Use cache if @current_researcher is already set
    if @current_researcher
      return @current_researcher
    end

    if logged_in?
      @current_researcher
    else
      raise "Attempting to look up logged in researcher, when the user isn't logged in."
    end
  end
end
