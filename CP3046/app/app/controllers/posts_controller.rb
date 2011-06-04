# Handles all posts interaction
class PostsController < ApplicationController
  before_filter :get_post, :only => [:destroy, :show]
  # User must be a moderator to destroy a post
  before_filter :must_be_moderator, :only => [:destroy]

  
  # Get the post from params
  def get_post
    @post = Post.find(params[:id])
  end

  # Validates the user as a moderator.
  # Selects appropriate redirect path based on current page.
  def must_be_moderator
    if @post
      login_required_as_moderator(post_path(@post))
    else
      login_required_as_moderator
    end
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
  # GET /posts/1.rss
  def show
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
  
  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

end
