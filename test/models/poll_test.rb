require "minitest_helper"

describe Poll do
  
  ## Testing Polls validations
  describe 'validations' do
    it 'should fail' do
      poll = Poll.create
      assert poll.errors.messages.has_key? :question
    end
  end


end
