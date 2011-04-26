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
        if logged_in?
			logged_in_researcher
        else
          notice = "Please log in"         
          redirect_to(new_session_url, :notice => notice)
        end
      end
      format.xml do   
        user = authenticate_with_http_basic do |login, password|
          Researcher.authenticate(login, password)
        end
        if user
          @current_user = user
        else
          request_http_basic_authentication
        end
      end
    end
  end


  def logged_in?
    session[:jc_number]
  end

  def logged_in_researcher
    if logged_in?
		begin
			@current_user = Researcher.find(session[:jc_number])
		rescue
			alert = "Existing session has become invalid. Please log in"         
			redirect_to(new_session_url, :alert => alert)
		end
	else
	end
  end
end
