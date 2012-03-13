require "minitest_helper"

describe Poll do
  
  ## Testing Polls validations
  describe 'validations' do
    it 'should fail' do
      poll = Poll.create
      assert poll.errors.messages.has_key? :question
    end
    
    it 'should create a poll' do
      poll = Poll.create :question => "Do you like this web?"
      assert poll.id.must_be :>, 0
    end
    
    it 'should fail becouse short' do
      poll = Poll.create :question => 'Hi'
      assert poll.id.must_be_nil
    end
  end


end
