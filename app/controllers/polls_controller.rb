class PollsController < ApplicationController
  def vote
    if params[:id_option]
      @poll = Poll.find(params[:id])
      @poll.vote(params[:id_option], request.ip) if @poll
    end
    
    render :vote_result
  end

  def vote_result
    @poll = @poll || Poll.find(params[:id])

    respond_to do |format|
      format.js
    end
  end
  
  def poll_options
    @poll = @poll || Poll.find(params[:id])

    respond_to do |format|
      format.js
    end
  end
end
