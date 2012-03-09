require "minitest_helper"

describe PollVote do
  
  ## Testing Poll votes validations
  describe 'validate' do
    describe 'fields' do
      #validate model validations on fields
    end
    
    describe 'functions' do
      before :each do
        @poll = Poll.create(:question => "Test")
        @poll.poll_options.create([{:option => "A"}, {:option => "B"}])
        @option = @poll.poll_options.first
    
        @ip = "1.1.1.1"
      end
  
      it 'should be voted' do
        @poll.vote(@option.id, @ip)
        assert @poll.voted @ip
      end

      it 'should be voted just 1 time' do
        PollVote.delete_all
        
        @poll.vote(@option.id, @ip)
        @poll.vote(@option.id, @ip)

        assert PollVote.all.count.must_be_same_as 1
      end


    end
    
  end


end