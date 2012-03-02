class Vote < ActiveRecord::Base
  belongs_to :article_comment
end
