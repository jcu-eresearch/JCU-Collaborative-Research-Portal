class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '45cee7d63e12a98bccc4f673bd4068ff'
    
  helper_method :logged_in?
  helper_method :logged_in_researcher
  helper_method :login_required_as_researcher

  before_filter :login_required_as_any_researcher


  private

  def login_required_as_any_researcher
    respond_to do |format|
      format.html do
        unless logged_in?
          notice = "Please log in"         
          redirect_to(new_session_url, :notice => notice)
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
          redirect_to(new_session_url, :notice => notice)
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
