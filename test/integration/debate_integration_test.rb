require "minitest_helper"

describe "Debate integration" do
  
  before :each do
    @user = User.create :email => 'test@test.com', :username => 'test_user', :password => '123456', :password_confirmation => '123456'
    @user.confirm!
    
    @debate = @user.debates.create :title => "Debate test one", :description => "kjdjkfdhsjkfhdfjkshjfkds"
    @debate = @user.debates.create :title => "Debate test two", :description => "dhsjskjdskdhsjkdhsjdhkshdkjshadjhsjdhskadshkas"
  end
    
    describe "Debates" do
      
      it "View the debates page" do
        visit '/debates'
        assert page.has_content?('Debates').must_be_same_as true
      end
      
      it "View debates list" do
        visit '/debates'
        assert page.has_content?('Debate test one').must_be_same_as true
        assert page.has_content?('Debate test two').must_be_same_as true
      end
      
      it "Can't add a debate" do
        visit '/debates'
        click_on('New Debate')
        assert page.has_content?('Need Login').must_be_same_as true
      end
      
      it "Can view a full debate" do
        visit '/debates/1'
        assert page.has_content?('Debates').must_be_same_as true
      end
      
      # it "Can add a debate" do
      #       #First of all SIGN IN
      #          visit '/'
      #          click_link('Sign In')
      #          fill_in('user_email', :with => 'test@test.com')
      #          fill_in('user_password', :with => '123456') 
      #          click_on('signin_button')
      #          #then...
      #          visit '/debates'
      #          click_on('New Debate')
      #          fill_in('debate_text_field', :with => 'Some debate')
      #          fill_in('debate_text_area', :with => 'The description for the debate')
      #          click_on("Create")
      #          assert Debate.last.title.must_equal('Some debate')
      #        end
      
    end
    
end