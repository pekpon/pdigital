class CommentsController < ApplicationController
  
  skip_before_filter :store_location
  
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
          
          RealTime.create!  :trackeable_id => @comment.id, 
                            :trackeable_type => "Comment", 
                            :subtype => @commentable.class.to_s, 
                            :user_id => current_user
                            
          format.html { redirect_to @commentable, notice: t(:comment_succefull) }
        else
          format.html { redirect_to :back, alert: t(:comment_error) }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to :back, alert: t(:captcha_error)}
      end
    end
  end
  
  def vote
    @comment = Comment.find(params[:id])
    vote = @comment.vote(params[:vote_type], request.ip) if @comment
    
    RealTime.create!  :trackeable_id => vote.id, 
                              :trackeable_type => "Vote", 
                              :subtype => vote.comment.commentable.class.to_s, 
                              :user_id => nil if vote
    
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
