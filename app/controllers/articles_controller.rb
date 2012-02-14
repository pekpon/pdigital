class ArticlesController < ApplicationController
  before_filter :store_location
  impressionist :actions=>[:show]

  def store_location
      session[:user_return_to] = request.url unless params[:controller] == "devise/sessions"
      # If devise model is not User, then replace :user_return_to with :{your devise model}_return_to
  end

  def after_sign_in_path_for(resource)
      stored_location_for(resource) || root_path
  end

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.where('category_id <> 3 AND category_id <> 4').order('id DESC')
    @categories = Category.order('name').all
    @articles_sport = Article.where(:category_id => 3).order('id DESC')
    @articles_opinion = Article.where(:category_id => 4).order('id DESC')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @poll = Poll.last
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  #def edit
  # @article = Article.find(params[:id])
  #end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
  
  def vote
    respond_to do |format|
      format.js
    end
  end
end
