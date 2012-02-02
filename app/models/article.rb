class Article < ActiveRecord::Base
	belongs_to :category
	has_many :article_comments
	is_impressionable
end
