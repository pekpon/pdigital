class ContactController < ApplicationController
  def index
    @message = Message.new
     respond_to do |format|
       format.html # index.html.erb
     end
   end
   
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid? and simple_captcha_valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Email enviat correctament!")
    else
      flash.now.alert = "Revisi que tots els camps son correctes"
      render :index
    end
  end

end
