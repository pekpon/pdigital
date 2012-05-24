class DebatesController < InheritedResources::Base
  def index
    @debates = Debate.find(:all, :conditions => { :active => true }, :order => "created_at DESC")
    @debates_finished = []
    
    # Debate.joins(:comments).where(
    #     :comments => { :created_at => (Time.now-5.days)..(Time.now), 
    #     :active => true}).group("debates.id")
    
    @debate = Debate.new
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @debate = Debate.find(params[:id])
    @comments = @debate.comments.where(:active => true).order("created_at ASC")
    impressionist(@debate)
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def create
    @debate = Debate.new(params[:debate])
    @debate.user = current_user
    
    if simple_captcha_valid?
      respond_to do |format|
        if @debate.save
          format.html  { redirect_to(debate_path,
                        :notice => t(:debate_added)) }
        else
          format.html  { redirect_to(debate_path,
                        :alert => t(:debate_error)) }
        end
      end
    else
      respond_to do |format|
        format.html  { redirect_to(debate_path,
                      :alert => t(:captcha_error)) }
      end
    end
    
  end
end
