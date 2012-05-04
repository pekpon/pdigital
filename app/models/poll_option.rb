class PollOption < ActiveRecord::Base
  belongs_to :poll
  has_many :poll_votes
  
  validates :poll, :option, :presence => true
  
  def votes
    self.poll_votes.count
  end
  
  def percent
    if self.poll_votes.count > 0
      Float(self.poll_votes.count)/Float(self.poll.poll_votes.count)*100
    else
      0
    end
  end
end
