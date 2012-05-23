class RealTimeController < ApplicationController
  
  def index
    @objects = Article.find(:all, :conditions => { :created_at => (Time.now-48.hours)..(Time.now), :published => true })
    @objects = @objects + Comment.find(:all, :conditions => {  :created_at => (Time.now-48.hours)..(Time.now), :active => true, :commentable_type => "Article" })
    @objects = @objects + Vote.find(:all, :conditions => {  :created_at => (Time.now-48.hours)..(Time.now) })
    
    @votes = Vote.find(:all, :conditions => {  :created_at => (Time.now-48.hours)..(Time.now) })
    
    @objects.sort! {|x,z| x.created_at <=> z.created_at}
    @objects.reverse!
    
  end
  
end
