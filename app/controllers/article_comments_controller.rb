class ArticleCommentsController < ApplicationController
  # POST /article_comments
  # POST /article_comments.json
  def create
    
    #:active => true
    
    @article_comment = ArticleComment.new(:article_id => params[:article_comment][:article_id],
                                          :comment => params[:article_comment][:comment], 
                                          :user => current_user,
                                          :active => true)
    @article = @article_comment.article
    
#params[:article_comment],

    respond_to do |format|
      if @article_comment.save
        format.html { redirect_to @article, notice: 'Comment was successfully created.' }
        format.json { render json: @article_comment, status: :created, location: @article_comment }
      else
        format.html { render action: "new" }
        format.json { render json: @article_comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
