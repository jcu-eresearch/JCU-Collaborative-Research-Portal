class PostsController < ApplicationController
  before_filter :get_post, :only => [:destroy, :show]
  # User must be a moderator or the owner of the post to destroy it
  before_filter :must_be_moderator_or_poster, :only => [:destroy]

  
  # Get the post from params
  def get_post
    @post = Post.find(params[:id])
  end

  # Validates the user as a moderator or the owner of the post.
  def must_be_moderator_or_poster
    login_required_as_moderator_or_researcher(@post.researcher, post_path(@post))
  end
  
  # GET /posts
  # GET /posts.xml
  # GET /posts.rss
  def index
    respond_to do |format|
      format.html { 
        @posts = Post.search(params[:search_title], params[:search_tags], params[:page])
      }
    
      format.rss  { 
        @posts = Post.all
        render :layout => false 
      }

      format.xml  { 
        @posts = Post.all
        render :xml => @posts
      }
      
      format.json { 
        @posts = Post.all
        render :json => @posts
      }
    end
  end


  # GET /posts/1
  # GET /posts/1.xml
  # GET /posts/1.rss
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
      format.json { render :json => @post }
      format.rss  { render :layout => false }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
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
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url, :notice => "Post (#{@post.title}) was successfully deleted.") }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end
