require "minitest_helper"

describe Debate do
  
  ## Testing Debate validations
  describe 'validations' do
    it 'should fail' do
      debate = Debate.create
      [:title, :description].each do |key|
        assert debate.errors.messages.has_key? key
      end
    end
    
    it 'should create and debate' do
      debate = Debate.create :title => 'Cursa', :description => 'Cursa cursa cursa'
      assert debate.id.must_be :>,0
    end
    
    it 'shouldnt create and debate without nothing' do
      debate = Debate.create :title => '', :description => ''
      assert debate.id.must_be_nil
    end
    
    it 'shouldnt create and debate without description' do
      debate = Debate.create :title => 'hdshshks', :description => ''
      assert debate.id.must_be_nil
    end
    
    it 'shouldnt create and debate without title' do
      debate = Debate.create :title => '', :description => 'dasdsadsadasd'
      assert debate.id.must_be_nil
    end
    
    it 'shouldnt create and debate' do
      debate = Debate.create :title => 'asdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjklaasdfghjkla', :description => 'dssadaad'
      assert debate.id.must_be_nil
    end
    
  end

end