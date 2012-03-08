require "minitest_helper"

describe PollOption do
  
  ## Testing Polls Options validations
  describe 'validations' do
    it 'should fail' do
      option = PollOption.create
      [:poll, :option].each do |key|
        assert option.errors.messages.has_key? key
      end
    end
  end


end