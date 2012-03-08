require "minitest_helper"

describe Category do
  
  ## Testing Polls validations
  describe 'validations' do
    it 'should fail' do
      cat = Category.create
      assert cat.errors.messages.has_key? :name
    end
  end


end