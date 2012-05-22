require "minitest_helper"

describe "Real Time integration" do
  before :each do
    article = Article.create! :category => Category.create(:name => 'test'), :body => 'Esto es un body', :title => 'aun menos', 
      :published_date => Time.now
    user = User.create(:username => 'test', :email => 'a@a.com', :password => '123456')
    user.confirm!
    
    comment = article.comments.create :user => user, :body => 'gagagag', :active => true
    
    comment.vote(1, "1.1.1.1") 
    comment.vote(1, "12.1.2.1") 
    comment.vote(1, "13.2.1.1") 
    comment.vote(1, "22.1.1.1")
    comment.vote(1, "11.1.1.2") 
    comment.vote(1, "16.1.1.3") 
    comment.vote(1, "17.1.13.1") 
    comment.vote(1, "18.1.1.1")
    comment.vote(1, "19.13.1.1") 
    comment.vote(1, "13.1.1.13") 
    comment.vote(1, "111.1.331.1") 
    comment.vote(1, "131.1.1.1")
    comment.vote(1, "311.1.1.1") 
    comment.vote(1, "112.1.1.31") 
    comment.vote(1, "123.133.1.1") 
    comment.vote(1, "145.31.1.1")
    
    

  end
  
   describe "Real Time" do
     it "View the real time page" do
       visit '/real_time'
       assert page.has_content?('Real Time').must_be_same_as true
     end
   end
    
end