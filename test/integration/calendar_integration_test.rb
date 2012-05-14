require "minitest_helper"

describe "Calendar integration" do
  
  before :each do
    @user = User.create :email => 'test@test.com', :username => 'test_user', :password => '123456', :password_confirmation => '123456'
    @user.confirm!
    
    @event = Event.create :name => "TEST", :start_at => "2012-01-01 00:00:00", :end_at => "2012-01-01 20:00:00", :active => true
    @event = Event.create :name => "TEdfsfsST", :start_at => "2012-01-01 00:00:00", :end_at => "2012-01-01 20:00:00", :active => false
  end
    
    describe "Calendar" do
      
      it "View the calendar page" do
        visit '/calendar'
        assert page.has_content?('Calendar').must_be_same_as true
      end
      
      it "Can add an event" do
        #First of all SIGN IN
        visit '/'
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456') 
        click_on('signin_button')
        #then...
        visit '/calendar'
        click_on('Add Event')
        fill_in('event_name', :with => 'TEST_EVENT')
        click_on("Add Event")
        assert page.has_content?('event_added').must_be_same_as true
      end
      
      it "Can't add an event" do
        visit '/calendar'
        click_on('Add Event')
        assert page.has_content?('Need Login').must_be_same_as true
      end
      
      it "Can view a full event" do
        visit '/events/1'
        assert page.has_content?('Event').must_be_same_as true
      end
      
      it "Can't view a full event" do
         visit '/events/2'
          assert page.has_content?('Calendar').must_be_same_as true
      end
      
      
    end
    
end