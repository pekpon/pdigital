class Poll < ActiveRecord::Base
  has_many :poll_options
  has_many :poll_votes
  
  def to_s
    self.question
  end
  
  def vote(id, ip)
    self.poll_votes.create! :id_option => id, :ip => ip
  end
end
