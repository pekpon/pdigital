class PollsController < ApplicationController
  def index
    @polls = Poll.page(params[:page]).per(3).order("id DESC")
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def vote
    if params[:id_option]
      @poll = Poll.find(params[:id])
      @poll.vote(params[:id_option], request.remote_ip) if @poll
    end 
    
    respond_to do |format|
      format.html { redirect_to polls_url }
      format.js   { render :vote_result }
    end
  end
end
