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
    
    it 'should create an option' do
      option = PollOption.create :poll => Poll.create(:question => "Do you like this?"), :option => "Yes"
      assert option.id.must_be :>,0
    end
  end


end