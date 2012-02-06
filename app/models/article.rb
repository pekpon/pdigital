class Article < ActiveRecord::Base
	belongs_to :category
	has_many :article_comments
	is_impressionable
	
	has_attached_file :avatar, :styles => { :detail => "650x650>", :medium => "330x330>", :thumb => "100x100>" }
	
end
