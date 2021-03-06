class EventsController < ApplicationController
  def new
    @event = Event.new
    
    respond_to do |format|
      #format.html  # new.html.erb
      format.js 
    end
  end
  
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        
        RealTime.create!  :trackeable_id => @event.id, 
                          :trackeable_type => "Event", 
                          :subtype => "New", 
                          :user_id => current_user
        
        format.html  { redirect_to(calendar_path,
                      :notice => t(:event_added)) }
      else
        format.html  { render :action => "new" }
      end
    end
  end
  
  def show
    @event = Event.find(params[:id])
    @comments = @event.comments.where(:active => true).order("created_at ASC")
    
    if @event.active == true
      
      respond_to do |format|
        format.html  # show.html.erb
      end
    else
      respond_to do |format|
        format.html  { redirect_to(calendar_path, :alert => "Event error")}
      end
    end
  end
  
end
