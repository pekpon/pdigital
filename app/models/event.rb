class Event < ActiveRecord::Base
  has_event_calendar
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates :name, :start_at, :end_at, :presence => true
end
