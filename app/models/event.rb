class Event < ActiveRecord::Base
  has_event_calendar
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  validates :name, :start_at, :end_at, :presence => true
  
  def full_description
    if self.description.present?
		  self.description.gsub(/\n/, '<br/>')
		else
		  "..."
		end
  end
  
  def short_description
      if self.description.present?
  		  self.description.slice(0,75) + "..."
      else
  		  "..."
  		end
  end
end
