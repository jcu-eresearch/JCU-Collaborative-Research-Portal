class PostsController < ApplicationController

  # GET /posts
  # GET /posts.xml
  def index
	respond_to do |format|
      format.html { 
	    # index.html.erb
#		@posts = Post.paginate :page => params[:page], :order => 'updated_at DESC'
		@posts = Post.search(params[:search], params[:page])
	  }
	  
	  format.rss  { 
		  @posts= Post.all
		  render :layout => false 
	  }

      format.xml  { 
		  @posts= Post.all
		  render :xml => @posts
      }

    end
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
	  format.rss  { render :layout => false }
    end
  end


  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
	@post.researcher = logged_in_researcher 

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
end
