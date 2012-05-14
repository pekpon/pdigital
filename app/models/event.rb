class Event < ActiveRecord::Base
  has_event_calendar
  
  validates :name, :start_at, :end_at, :presence => true
end
