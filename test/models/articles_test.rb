require "minitest_helper"

describe Article do
  
  ## Testing Articles validations
  describe 'validations' do
    it 'should fail' do
      article = Article.create
      [:category, :body, :title, :published_date].each do |key|
        assert article.errors.messages.has_key? key
      end
    end
  end


end
