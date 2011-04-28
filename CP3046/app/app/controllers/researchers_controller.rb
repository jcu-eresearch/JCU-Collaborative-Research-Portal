class ResearchersController < ApplicationController

  # GET /researchers
  # GET /researchers.xml
  def index
    respond_to do |format|
      format.html { # index.html.erb
		@researchers = Researcher.paginate :page => params[:page], :order => 'updated_at DESC'
	  }
      format.xml  { 
		  @researchers = Researcher.all
		  render :xml => @researchers }

    end
  end

  # GET /researchers/1
  # GET /researchers/1.xml
  def show
    @researcher = Researcher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @researcher }
	  format.rss  { render :layout => false }
    end
  end
  
  # GET /researchers/1/account
  def account
    @researcher = Researcher.find(params[:id])
	
	# Only viewable by the logged in researcher
	if @researcher == logged_in_researcher
		respond_to do |format|
		  format.html # account.html.erb
		  format.rss  { render :layout => false }
		end
	else
		respond_to do |format|
			format.html { redirect_to(account_researcher_path(logged_in_researcher), :alert => "You can't view another user's account.") }
			format.xml  { render :xml => {"error" => "You can't view another user's account"}, :status => :unprocessable_entity }
			format.rss  { render :xml => {"error" => "You can't view another user's account"}, :status => :unprocessable_entity }
		end
	end

  end
  
  # GET /researchers/1/research
  def research 
    @researcher = Researcher.find(params[:id])

    respond_to do |format|
      format.html # research.html.erb
    end
  end

  # GET /researchers/1/edit
  def edit
    @researcher = Researcher.find(params[:id])
  end
  
  # PUT /researchers/1
  # PUT /researchers/1.xml
  def update
    @researcher = Researcher.find(params[:id])
	
	# Only allow the user to change the details of the researcher, if the researcher is the current user.
  	if logged_in_researcher == @researcher
		respond_to do |format|
		  if @researcher.update_attributes(params[:researcher])
			format.html { redirect_to(@researcher, :notice => 'Researcher was successfully updated.') }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @researcher.errors, :status => :unprocessable_entity }
		  end
		end
	else
		respond_to do |format|
			format.html { redirect_to(@researcher, :alert => "You can't update another user's details.") }
			format.xml  { render :xml => {"error" => "You can't update another user's details"}, :status => :unprocessable_entity }
		end
	end
  end

end
