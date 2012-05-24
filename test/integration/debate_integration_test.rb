require "minitest_helper"

describe "Debate integration" do
  
  before :each do
    @user = User.create :email => 'test@test.com', :username => 'test_user', :password => '123456', :password_confirmation => '123456'
    @user.confirm!
    
    for i in 0..5
       @debate = @user.debates.create :title => "Debate num #{i}", :description => "Debate text #{i}"
       @comment = @user.comments.create :body => "comment one", :commentable => @debate, :commentable_type => "Debate", :active => true
    end
  end
    
    describe "Debates" do
      
      it "View the debates page" do
        visit '/debates'
        assert page.has_content?('Debates').must_be_same_as true
      end
      
      it "View debates list" do
        visit '/debates'
        assert page.has_content?('Debate num 1').must_be_same_as true
        assert page.has_content?('Debate num 2').must_be_same_as true
        assert page.has_content?('Debate num 3').must_be_same_as true
        assert page.has_content?('Debate num 4').must_be_same_as true
        assert page.has_content?('Debate num 5').must_be_same_as true
      end
      
      it "Can't add a debate" do
        visit '/debates'
        click_on('New Debate')
        assert page.has_content?('Need Login').must_be_same_as true
      end
      
      it "Can view a full debate" do
        visit '/debates/debate-num-1'
        assert page.has_content?('Debate num 1').must_be_same_as true
      end
      
      it "Can view a debate messages" do
        visit '/debates/debate-num-1'
        assert page.has_content?("test_user").must_be_same_as true
      end
      
      # it "Can vote a debate message" do
      #         visit '/debates/debate-num-1'
      #         click_on('Vote Ok')
      #         assert Vote.first.vote_type.must_equal(1)
      #       end
      
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