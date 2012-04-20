class CategoriesController < ApplicationController
  # GET /categories
   def index
     @categories = Category.all

     respond_to do |format|
       format.html # index.html.erb
     end
   end

   # GET /categories/1
   def show
     @category = Category.find(params[:id])
     @articles = @category.articles.order('id DESC').page(params[:page]).per(10)

     respond_to do |format|
       format.html # show.html.erb
     end
   end
end
