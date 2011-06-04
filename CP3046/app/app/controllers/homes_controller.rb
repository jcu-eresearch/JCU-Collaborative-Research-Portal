# Handles root (/) requests
# Acts as home-page.
#
# Only section of the site that can be access without being logged in.
class HomesController < ApplicationController
  # You don't need to be logged in to view the home pages
  skip_before_filter :login_required_as_any_researcher
  
  # GET /home
  def index 
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /home/support
  def support
    respond_to do |format|
      format.html # support.html.erb
    end
  end

  # GET /home/about
  def about
    respond_to do |format|
      format.html # about.html.erb
    end
  end

end
