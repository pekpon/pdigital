class Commerce < ActiveRecord::Base
  
  has_many :comments, :as => :commentable
  belongs_to :user
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates :name, :street, :telephone, :presence => true
  
  validates :name, :length => { :maximum => 150 }
  validates :street, :length => { :maximum => 200 }
  validates :telephone, :length => { :maximum => 15 }
  
  has_attached_file :image, :styles => { :large => "600x600>", :inside => "300x300#", :index => "260x170#" }
  
end
