class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :article
  belongs_to :user
  belongs_to :debate
  has_many :votes
  before_save :clean
  
  validates :body, :presence => true
  validates :body, :length => { :minimum => 2 }
  validates :body, :uniqueness => { :scope => [:user_id, :commentable_id, :active] }
  
  def vote(type, ip)
    self.votes.create! :vote_type => type, :ip => ip
  end
  
  def delete
    self.active = false
    self.save!
  end
  
  def vots_result
    positive = self.votes.where(:vote_type => 1)
    negative = self.votes.where(:vote_type => 2)
    total = positive.count - negative.count
    return total
  end
  
  def voted(ip)
    voted = self.votes.where(:ip => ip)
    if voted.count == 0
      return false
    else
      return true
    end
  end
  
  def show_body 
    my_body = self.body.gsub(/\n/, '<br>')
  end


  private
  
  def clean
    self.body = Sanitize.clean(self.body, :elements => ['a','b','br'])
  end
  
  
end
  