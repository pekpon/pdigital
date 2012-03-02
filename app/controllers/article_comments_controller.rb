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
        format.html { redirect_to @article, notice: t(:comment_succefull) }
      else
        format.html { redirect_to @article, alert: t(:comment_error) }
      end
    end
  end
  
  def vote
    @comment = ArticleComment.find(params[:id])
    @comment.vote(params[:vote_type], request.ip) if @comment
    respond_to do |format|
      format.js
    end
  end
end


