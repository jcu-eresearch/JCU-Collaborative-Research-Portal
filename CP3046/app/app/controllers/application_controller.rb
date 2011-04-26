class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '45cee7d63e12a98bccc4f673bd4068ff'
    
  helper_method :logged_in?
  helper_method :logged_in_researcher

  before_filter :login_required


  private

  def login_required
    respond_to do |format|
      format.html do
        unless logged_in?
          notice = "Please log in"         
          redirect_to(new_session_url, :notice => notice)
        end
      end
      format.xml do   
        user = authenticate_with_http_basic do |login, password|
          Researcher.authenticate(login, password)
        end
        if user
          @current_researcher = user
        else
          request_http_basic_authentication
        end
      end
      format.rss do   
        user = authenticate_with_http_basic do |login, password|
          Researcher.authenticate(login, password)
        end
        if user
          @current_researcher = user
        else
          request_http_basic_authentication
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
  	# Early exit if @current_researcher is already set. (caching)
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
