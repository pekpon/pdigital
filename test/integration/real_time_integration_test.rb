require "minitest_helper"

describe "Real Time integration" do
  before :each do
    user = User.create(:username => 'test', :email => 'a@a.com', :password => '123456')
    user.confirm!
    
    article = Article.create! :category => Category.create(:name => 'test'), :body => 'Esto es un body', :title => 'Article', 
    :published_date => Time.now
    event = Event.create! :title => "Event", :description => "some description", :start_at => "2012-01-01 00:00:00", :end_at => "2012-01-01 20:00:00", :active => true
    debate = user.debates.create :title => "Debate", :description => "Debate text"
    
    
    acomment = article.comments.create :user => user, :body => 'gagagag', :active => true
    acomment = article.comments.create :user => user, :body => 'gagdsadsadaagag', :active => true
    
    dcomment = debate.comments.create :user => user, :body => 'gagdsadsadaagag', :active => true
    dcomment = debate.comments.create :user => user, :body => 'gagagag', :active => true
    
    ecomment = event.comments.create :user => user, :body => 'gagdsadsadaagag', :active => true
    ecomment = event.comments.create :user => user, :body => 'gagagag', :active => true
    
    acomment.vote(1, "1.1.1.1") 
    acomment.vote(1, "12.1.2.1") 
    acomment.vote(1, "13.2.1.1") 
    acomment.vote(1, "22.1.1.1")
    acomment.vote(1, "11.1.1.2") 
    acomment.vote(1, "16.1.1.3") 
    acomment.vote(1, "17.1.13.1") 
    acomment.vote(1, "18.1.1.1")
    acomment.vote(1, "19.13.1.1") 
    acomment.vote(1, "13.1.1.13") 
    acomment.vote(1, "111.1.331.1") 
    acomment.vote(1, "131.1.1.1")
    acomment.vote(1, "311.1.1.1") 
    acomment.vote(1, "112.1.1.31") 
    acomment.vote(1, "123.133.1.1") 
    acomment.vote(1, "145.31.1.1")
    
    

  end
  
   describe "Real Time" do
     it "View the real time page" do
       visit '/real_time'
       assert page.has_content?('Real Time').must_be_same_as true
     end
   end
    
end