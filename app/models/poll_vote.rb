class PollVote < ActiveRecord::Base
  belongs_to :poll
  belongs_to :poll_option
  
  validates :ip, :poll_option_id, :presence => true
end
