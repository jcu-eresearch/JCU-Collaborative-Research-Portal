class SessionsController < ApplicationController
  skip_before_filter :login_required_as_any_researcher

  def new
  end

  def create
    forward_to = params[:forward_to]
    researcher = Researcher.authenticate(params[:login], params[:password])
    if researcher 
      session[:jc_number] = researcher.id
      notice = "Welcome #{researcher.name}"
      if forward_to
        redirect_to forward_to, :notice => notice 
      else
        redirect_to(account_researcher_path(researcher), :notice => notice)
      end
    else
      alert = "The username or password you entered is incorrect."
      if forward_to
        redirect_to(new_session_url(:forward_to => forward_to), :alert => alert) 
      else
        redirect_to(new_session_url, :alert => alert) 
      end
    end
  end

  def destroy
    reset_session
    notice = "You've been logged out."
    redirect_to(new_session_url, :notice=> notice) 
  end
end
