class PollsController < ApplicationController
  def vote
    @poll = Poll.find(params[:id])
    @poll.vote(params[:id_option], request.ip) if @poll
    
    respond_to do |format|
      format.js
    end
  end
end
