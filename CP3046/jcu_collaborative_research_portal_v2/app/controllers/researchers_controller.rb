class ResearchersController < ApplicationController
  before_filter :get_researcher, :except => [:index]
  
  # Don't use the standard authentication on the account, edit or update pages.
  skip_before_filter :login_required_as_any_researcher, :only => [:account, :edit, :update]

  # Instead...

  # Authenticate the user against the user that owns the page
  # Only allow researcher Bob to edit Bob's profile
  before_filter :only => [:account, :edit, :update] do |controller|
    login_required_as_researcher(@researcher, researcher_url(@researcher)) 
  end

  # Get the researcher from params
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
      format.json { 
        @researchers = Researcher.all
        render :json => @researchers 
      }
    end
  end

  # GET /researchers/1
  # GET /researchers/1.xml
  def show
    if @researcher == logged_in_researcher
      respond_to do |format|
        format.html { render :layout => 'account' } # account.html.erb
        format.xml  { render :xml => @researcher }
        format.json { render :json => @researcher }
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @researcher }
        format.json { render :json => @researcher }
      end
    end
  end

  # GET /researchers/1/account
  # GET /researchers/1/account.rss
  def account
    respond_to do |format|
      format.html { render :layout => 'account' } # account.html.erb
      format.rss  { render :layout => false }
    end
  end

  # GET /researchers/new
  # GET /researchers/new.json
  def new
    @researcher = Researcher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @researcher }
    end
  end

  # GET /researchers/1/edit
  def edit
    @researcher = Researcher.find(params[:id])
  end

  # POST /researchers
  # POST /researchers.json
  def create
    @researcher = Researcher.new(params[:researcher])

    respond_to do |format|
      if @researcher.save
        format.html { redirect_to @researcher, notice: 'Researcher was successfully created.' }
        format.json { render json: @researcher, status: :created, location: @researcher }
      else
        format.html { render action: "new" }
        format.json { render json: @researcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /researchers/1
  # PUT /researchers/1.json
  def update
    @researcher = Researcher.find(params[:id])

    respond_to do |format|
      if @researcher.update_attributes(params[:researcher])
        format.html { redirect_to @researcher, notice: 'Researcher was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @researcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /researchers/1
  # DELETE /researchers/1.json
  def destroy
    @researcher = Researcher.find(params[:id])
    @researcher.destroy

    respond_to do |format|
      format.html { redirect_to researchers_url }
      format.json { head :ok }
    end
  end
end
