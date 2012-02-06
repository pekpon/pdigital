class ArticleComment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :votes
  
  def vote(type, ip)
    self.votes.create! :vote_type => type, :ip => ip
  end
  
  def vots_result
    positive = self.votes.where(:vote_type => 1)
    negative = self.votes.where(:vote_type => 2)
    total = positive.count - negative.count
    return total
  end
end
