class ArticlesController < ApplicationController
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
    
    if params[:search].present?
      
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

      @words = params[:search] 
    else
      @words = "..."
      @little_words = false
      @total_articles = 0
    end
    
    respond_to do |format|
      format.html # search.html.erb
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.where(:active => true).order("created_at ASC")
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
