class TheMostsController < ApplicationController
  def index
    @articles_commented = Article.get_comments(:comments_count)
    @articles_viewed = Article.get_comments
    
    respond_to do |format|
      format.html # index.html.erb
    end
    
  end
  
  def day
    @articles_commented = Article.get_comments(:comments_day)
    @articles_viewed = Article.get_comments(:views_day)
    
    respond_to do |format|
      format.html # day.html.erb
    end
  end
  
  def month
     @articles_commented = Article.get_comments(:comments_month)
     @articles_viewed = Article.get_comments(:views_month)

     respond_to do |format|
       format.html # month.html.erb
     end
   end
  
end
