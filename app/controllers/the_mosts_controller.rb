class TheMostsController < ApplicationController
  def index
    @articles_commented = Article.get_comments(:comments_count)
    @articles_viewed = Article.get_comments
    
    respond_to do |format|
      format.html # index.html.erb
    end
    
  end
  
end
