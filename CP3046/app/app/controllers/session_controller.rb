class SessionController < ApplicationController
  skip_before_filter :login_required
  
  def new
  end

  def create
    researcher = Researcher.authenticate(params[:login], params[:password])
    if researcher 
      session[:jc_number] = researcher.id
      notice = "Welcome #{researcher.name}"
      redirect_to(researcher, :notice => notice)
    else
      alert = "The username or password you entered is incorrect."
      redirect_to(new_session_url, :alert => alert) 
    end
  end

  def destroy
    reset_session
    notice = "You've been logged out."
    redirect_to(new_session_url, :notice=> notice) 
  end
end
