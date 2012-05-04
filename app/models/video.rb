class Video < ActiveRecord::Base
  belongs_to :article
  
  validates :youtube_code, :article_id, :presence => true
  validates :height, :numericality => { :only_integer => true }
  validates :width, :numericality => { :only_integer => true }
end
