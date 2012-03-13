class Vote < ActiveRecord::Base
  belongs_to :article_comment
  
  validates :ip, :vote_type, :presence => true
  validates :ip, :uniqueness => {:scope => :article_comment_id}
end
