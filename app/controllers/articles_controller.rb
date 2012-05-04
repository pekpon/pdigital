class ArticlesController < ApplicationController
  before_filter :store_location
  #impressionist :actions=>[:show]

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
    sport = ::Configuration.value :sports_id
    opinion = ::Configuration.value :opinion_id
    @articles = Article.active.general(sport,opinion).order("id DESC").limit(15)
    @categories = Category.order('name').all
    @articles_sport = Article.active.category(sport).order("id DESC").limit(15)
    @articles_opinion = Article.active.category(opinion).order("id DESC").limit(15)
  
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def search
    
    @articles = []
    
    Article.all.each do |article|
      @articles << article if article.search(params[:search])
    end
  
    @total_articles = @articles.count
    @articles = @articles.reverse
    @articles = Kaminari.paginate_array(@articles).page(params[:page]).per(10)
    
    @little_words = false
    search = params[:search].split(' ')
    search.each do |word|
      if word.length <= 3
        @little_words = true
      end
    end
    
    if params[:search].blank?
      @words = "..."
    else
      @words = params[:search] 
    end
    
    respond_to do |format|
      format.html # search.html.erb
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @poll = Poll.last
    @most_moved = Article.most_moved

    impressionist(@article)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end
  
  def vote
    respond_to do |format|
      format.js
    end
  end
  
  def rss
    @articles = Article.find(:all, :order => "id DESC", :limit => 20)

    respond_to do |format|
       format.rss { render :layout => false }
       format.xml
    end
  end
end
