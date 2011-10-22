class ResearchersController < ApplicationController
  before_filter :get_researcher, :except => [:index]
  
  # Don't use the standard authentication on the account, edit or update pages.
  skip_before_filter :login_required_as_any_researcher, :only => [:account, :edit, :update]

  # Instead...

  # Authenticate the user against the user that owns the page
  # Only allow researcher Bob to edit Bob's profile
  before_filter :only => [:account, :edit, :update, :like_tag, :dislike_tag, :forget_tag] do |controller|
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
        format.html { render :layout => 'account' }
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
      format.html { redirect_to @researcher }
      format.xml  { render :xml => @researcher }
      format.json { render :json => @researcher }
      format.rss  { 
        @display_posts = {}

        for post in Post.all(:limit => RSS_ITEM_LIMIT, :order => "created_at DESC") 
          commented_on_post = false
          commented_on_post = post.comments.select { |comment| comment.researcher == @researcher }.any?

          # Always show a post if you have liked one of its tags.
          # Show any post which doesn't have a tag that you have specifically disliked.
          # Always show a post I have commented on
          if ( (@researcher.liked_tag_list & post.tag_list).any? or (@researcher.disliked_tag_list & post.tag_list).empty? or commented_on_post )
            @display_posts[post] = []
          end

          # Show the comments for this post if I have either commented on it,
          # or I am the author of the post 
          if ( commented_on_post or ( post.researcher == @researcher ) )
            @display_posts[post] ||= []
            @display_posts[post] += post.comments(:limit => RSS_ITEM_LIMIT, :order => "created_at DESC")
          end
        end

        render :layout => false 
      }
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

  # PUT /researchers/1/like_tag.json
  # PUT /researchers/1/like_tag
  def like_tag 
    @researcher = Researcher.find(params[:id])
    tag = params[:tag]
    respond_to do |format|
      if tag
        @researcher.liked_tag_list.add(tag)
        @researcher.disliked_tag_list.remove(tag)
        if @researcher.save
          format.json { render json: { :success => "Researcher was successfully updated. Liked tag: #{tag}" } }
          format.html { redirect_to @researcher, notice: "Researcher was successfully updated. Liked tag: #{tag}" }
        else
          format.json { render json: @researcher.errors, status: :unprocessable_entity }
          format.html { redirect_to @researcher, alert: "Failed to like tag: #{tag.inspect}. Error: #{@researcher.errors.full_messages.join(', ')}" }
        end
      else
        @researcher.errors.add(:liked_tags, "Can't like tag, as no tag was provided")
        format.json { render json: @researcher.errors, status: :unprocessable_entity }
        format.html { redirect_to @researcher, alert: "Failed to like tag. Error: #{@researcher.errors.full_messages.join(', ')}" }
      end
    end
  end
  
  # PUT /researchers/1/forget_tag.json
  # PUT /researchers/1/forget_tag
  def forget_tag
    @researcher = Researcher.find(params[:id])
    tag = params[:tag]
    respond_to do |format|
      if tag
        @researcher.liked_tag_list.remove(tag)
        @researcher.disliked_tag_list.remove(tag)
        if @researcher.save
          format.json { render json: { :success => "Researcher was successfully updated. Forgot tag: #{tag}" } }
          format.html { redirect_to @researcher, notice: "Researcher was successfully updated. Forgot tag: #{tag}" }
        else
          format.json { render json: @researcher.errors, status: :unprocessable_entity }
          format.html { redirect_to @researcher, alert: "Failed to forget tag: #{tag.inspect}. Error: #{@researcher.errors.full_messages.join(', ')}" }
        end
      else
        @researcher.errors[:base] << "Can't forget tag, as no tag was provided"
        format.json { render json: @researcher.errors, status: :unprocessable_entity }
        format.html { redirect_to @researcher, alert: "Failed to forget tag. Error: #{@researcher.errors.full_messages.join(', ')}" }
      end
    end
  end
  
  # PUT /researchers/1/dislike_tag.json
  # PUT /researchers/1/dislike_tag
  def dislike_tag 
    @researcher = Researcher.find(params[:id])
    tag = params[:tag]
    respond_to do |format|
      if tag
        @researcher.disliked_tag_list.add(tag)
        @researcher.liked_tag_list.remove(tag)
        if @researcher.save
          format.json { render json: { :success => "Researcher was successfully updated. Disliked tag: #{tag}" } }
          format.html { redirect_to @researcher, notice: "Researcher was successfully updated. Disliked tag: #{tag}" }
        else
          format.json { render json: @researcher.errors, status: :unprocessable_entity }
          format.html { redirect_to @researcher, alert: "Failed to dislike tag: #{tag.inspect}. Error: #{@researcher.errors.full_messages.join(', ')}" }
        end
      else
        @researcher.errors.add(:disliked_tags, "Can't dislike tag, as no tag was provided")
        format.json { render json: @researcher.errors, status: :unprocessable_entity }
        format.html { redirect_to @researcher, alert: "Failed to dislike tag. Error: #{@researcher.errors.full_messages.join(', ')}" }
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

  def posts
    if @researcher == logged_in_researcher
      respond_to do |format|
        format.html { render :layout => 'account' } 
        format.xml  { render :xml => @researcher }
        format.json { render :json => @researcher }
      end
    else
      respond_to do |format|
        format.html # posts.html.erb
        format.xml  { render :xml => @researcher }
        format.json { render :json => @researcher }
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
