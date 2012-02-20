class TheMostsController < ApplicationController
  def index
    @articles_viwed = Article.first
    @articles_commented = Article.article_comments.order("article_comments ASC")
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
