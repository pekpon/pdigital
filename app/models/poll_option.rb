class PollOption < ActiveRecord::Base
  belongs_to :poll
  has_many :poll_votes
  
  def votes
    self.poll_votes.count
  end
  
  def percent
    Float(self.poll_votes.count)/Float(self.poll.poll_votes.count)*100
  end
end
