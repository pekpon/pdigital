class Debate < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable
  
	is_impressionable
	extend FriendlyId
  friendly_id :title, :use => :slugged
  validates :title, :description, :presence => true
  validates :title, :length => { :maximum => 140 }
  
  def end_date
    #If this debate has comments, these determine the end_date
    #Else, the created_date determine it
    if self.comments.count > 0
      last_date = self.comments.last.created_at
      last_date + 5.days
    else
      self.created_at + 5.days
    end
  end
  
  def active_days
    f1 = Time.now.strftime("%Y/%m/%d")
    f2 = self.created_at.strftime("%Y/%m/%d")
    (Date.parse(f1) - Date.parse(f2)).to_i + 1
  end
end
