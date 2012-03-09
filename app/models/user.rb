class User < ActiveRecord::Base
  has_many :article_comments
  
  validates :username, :presence => true
  validates :username, :uniqueness => true
  validates :username, :length => {:minimum => 4}
  validates :password, :presence => true
  validates :password, :length => {:minimum => 6}
  validates :email, :presence => true
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
end
