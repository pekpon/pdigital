require "minitest_helper"

describe Category do
  
  ## Testing Polls validations
  describe 'validations' do
    it 'should fail' do
      cat = Category.create
      assert cat.errors.messages.has_key? :name
    end
    
    it 'should fail duplicated name' do
      cat = Category.create :name => 'test'
      cat2 = Category.create :name => 'test'
      assert cat2.id.must_be_nil
    end
      
  end


end