require "minitest_helper"

describe "Commerces integration" do
  before :each do
    user = User.create(:username => 'test', :email => 'a@a.com', :password => '123456')
    user.confirm!
  end
  
   describe "Commerce test" do
     it "View commerces page" do
       visit '/commerces'
       assert page.has_content?('Commerces').must_be_same_as true
     end
     
     it "View commerces page with 1 commerce" do
       Commerce.create :name => "Test Commerce", :street => "test street 5", :telephone => "123456789", :active => true
        visit '/commerces'
        assert page.has_content?('Commerces').must_be_same_as true
      end
      
      it "View commerces detail" do
         Commerce.create :name => "Test", :street => "test street 5", :telephone => "123456789", :active => true
          visit '/commerces'
          click_link('Test')
          assert page.has_content?('test street 5').must_be_same_as true
        end
   end
    
end