class RealTimeController < ApplicationController
  
  def index

    # @objects = Article.where( :created_at => (Time.now-48.hours)..(Time.now), :published => true  )
    #    @objects = @objects + Debate.where( :created_at => (Time.now-48.hours)..(Time.now), :active => true )
    #    @objects = @objects + Event.where( :created_at => (Time.now-48.hours)..(Time.now), :active => true )
    #    
    #    @objects = @objects + Comment.where( :created_at => (Time.now-48.hours)..(Time.now), :active => true )
    #    @objects = @objects + Vote.where( :created_at => (Time.now-48.hours)..(Time.now) )
    #    
    #    @votes = Vote.where(:created_at => (Time.now-48.hours)..(Time.now) )
    #    
    #    @objects.sort! {|x,z| x.created_at <=> z.created_at}
    #    @objects.reverse!
    
    @objects = RealTime.where( :created_at => (Time.now-48.hours)..(Time.now), :trackeable_type => ["Article","Event","Debate","Comment"], :subtype => ["New","Event","Article","Debate"] ).order("created_at DESC")
    # @votes = Vote.where(:created_at => (Time.now-48.hours)..(Time.now) )
    
  end
  
end
