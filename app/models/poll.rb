class Poll < ActiveRecord::Base
  has_many :poll_options
  has_many :poll_votes
  
  validates :question, :presence => true
  validates :question, :length => { :minimum => 3 }
  
  def to_s
    self.question
  end
  
  def vote(id, ip)
    self.poll_votes.create!(:poll_option_id => id, :ip => ip) unless self.voted ip
  end
  
  def voted(ip)
    if self.poll_votes.where(:ip => ip).count == 0
      return false
    else
      return true
    end
  end
end
