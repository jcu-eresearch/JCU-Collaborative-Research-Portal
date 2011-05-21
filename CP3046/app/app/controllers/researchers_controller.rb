class ResearchersController < ApplicationController
  before_filter :get_researcher, :except => [:index]
	
  # Don't use the standard authentication on the account, edit or update pages.
  # Instead, authenticate the user against the user that owns the page
  # Only allow researcher Bob to edit Bob's profile
  skip_before_filter :login_required_as_any_researcher, :only => [:account, :edit, :update]

  before_filter :only => [:account, :edit, :update] do |controller|
    login_required_as_researcher(@researcher, researcher_url(@researcher)) 
  end

  def get_researcher
    @researcher = Researcher.find(params[:id])
  end

  # GET /researchers
  # GET /researchers.xml
  def index
    respond_to do |format|
      format.html { # index.html.erb
        @researchers = Researcher.search(params[:search_name], params[:page])
      }
      format.xml  { 
        @researchers = Researcher.all
        render :xml => @researchers 
      }
    end
  end

  # GET /researchers/1
  # GET /researchers/1.xml
  def show
    if @researcher == logged_in_researcher
      respond_to do |format|
        format.html { render :layout => 'account' } # show.html.erb
        format.xml  { render :xml => @researcher }
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @researcher }
      end
    end
  end
  
  # GET /researchers/1/account
  def account
		respond_to do |format|
		  format.html { render :layout => 'account' } # account.html.erb
		  format.rss  { render :layout => false }
		end
  end
  
  # GET /researchers/1/posts
	def posts
		if @researcher == logged_in_researcher
			respond_to do |format|
				format.html { render :layout => 'account' } # posts.html.erb
		    format.rss  { render :layout => false }
			end
		else
			respond_to do |format|
				format.html # research.html.erb
		    format.rss  { render :layout => false }
			end
		end
	end

  # GET /researchers/1/edit
	def edit
    respond_to do |format|
      format.html { render :layout => 'account' } # edit.html.erb
    end
	end
  
  # PUT /researchers/1
  # PUT /researchers/1.xml
  def update
    # Only allow the user to change the details of the researcher, if the researcher is the current user.
    respond_to do |format|
      if @researcher.update_attributes(params[:researcher])
        format.html { redirect_to(@researcher, :notice => 'Researcher was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @researcher.errors, :status => :unprocessable_entity }
      end
    end
  end
end
