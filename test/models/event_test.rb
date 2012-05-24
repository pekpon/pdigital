require "minitest_helper"

describe Event do
  
  ## Testing Event validations
  describe 'validations' do
    it 'should fail' do
      event = Event.create
      [:name, :start_at, :end_at].each do |key|
        assert event.errors.messages.has_key? key
      end
    end
    
    it 'should create and Event' do
      event = Event.create :name => 'Cursa', :description => 'Cursa cursa cursa', :start_at => '2012-01-01 10:00:00', :end_at => '2012-01-01 10:00:00'
      assert event.id.must_be :>,0
    end
    
    it 'should create and Event without description' do
      event = Event.create :name => 'Cursa', :start_at => '2012-01-01 10:00:00', :end_at => '2012-01-01 10:00:00'
      assert event.id.must_be :>,0
    end
    
    it 'should fail without name' do
      event = Event.create :start_at => '2012-01-01 10:00:00', :end_at => '2012-01-01 10:00:00'
      assert event.id.must_be_nil
    end
    
    it 'should fail without start' do
      event = Event.create :name => 'asasas', :start_at => '', :end_at => '2012-01-01 10:00:00'
      assert event.id.must_be_nil
    end
    
    it 'should fail without end' do
      event = Event.create :name => 'asasas', :start_at => '2012-01-01 10:00:00', :end_at => ''
      assert event.id.must_be_nil
    end
    
  end

end