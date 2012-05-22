class Vote < ActiveRecord::Base
  belongs_to :comment
  
  validates :ip, :vote_type, :presence => true
  validates :ip, :uniqueness => {:scope => :comment_id}
end
