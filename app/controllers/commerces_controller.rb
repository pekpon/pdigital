class CommercesController < ApplicationController
  
  def index
    commerces1 = Commerce.where(:active => true, :pro => true).order("name ASC")
    commerces2 = Commerce.where(:active => true, :pro => nil).order("name ASC")
    commerces3 = Commerce.where(:active => true, :pro => false).order("name ASC")
    
    @commerces = commerces1 + commerces2 + commerces3
    @commerce = Commerce.new
    
    respond_to do |format|
      format.html  # index.html.erb
    end
    
  end
  
  def show
    
    @commerce = Commerce.find(params[:id])
    @comments = @commerce.comments.where(:active => true).order("created_at ASC")
    
    respond_to do |format|
      format.html  # show.html.erb
    end
    
  end
  
  def create
    if params[:commerce][:active].to_i == 1
      if simple_captcha_valid?
        @commerce = Commerce.new(params[:commerce])
        @commerce.active = true
        @commerce.user = current_user

        respond_to do |format|
          if @commerce.save
            format.html  { redirect_to(commerces_path,
                          :notice => t(:commerce_added)) }
          else
            format.html  { redirect_to(commerces_path,
                          :alert => t(:commerce_error)) }
          end
        end
      
      else
        respond_to do |format|
            format.html  { redirect_to(commerces_path,
                          :alert => t(:captcha_error)) }
          end
      end
      
    else
      respond_to do |format|
          format.html  { redirect_to(commerces_path,
                        :alert => t(:active_error)) }
        end
    end
    
  end
end
