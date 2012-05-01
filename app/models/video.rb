class Video < ActiveRecord::Base
  belongs_to :article
  
  validates :youtube_code, :article_id, :presence => true
end
