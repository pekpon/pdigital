class CommentsController < ApplicationController
  def create
      @comment = Comment.new(:body => params[:comment][:body], 
                                            :user => current_user,
                                            :active => true, 
                                            :commentable_id => params[:comment][:id], 
                                            :commentable_type => params[:comment][:type])
                              
      @commentable = @comment.commentable
      
    if simple_captcha_valid?
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @commentable, notice: t(:comment_succefull) }
        else
          format.html { redirect_to @commentable, alert: t(:comment_error) }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to @commentable, alert: t(:captcha_error) }
      end
    end
  end
  
  def vote
    @comment = Comment.find(params[:id])
    @comment.vote(params[:vote_type], request.ip) if @comment
    respond_to do |format|
      format.js
    end
  end
  
  def delete
    @comment = Comment.find(params[:id])
            
    if @comment.user == current_user and @comment.created_at+15.minutes > Time.now
      @comment.delete
    end
    
    respond_to do |format|
      format.js
    end
  end
end
