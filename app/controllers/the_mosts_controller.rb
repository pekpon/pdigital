class TheMostsController < ApplicationController
  def index
    @articles_viwed = Article.first
    @articles_commented = Article.all
    
    respond_to do |format|
      format.html # index.html.erb
    end
    
  end
  
end
