require "minitest_helper"

describe "Articles integration" do
  before :each do
    @article_non = Article.create :title => 'My non showed article test', :body => 'The body of the test article', 
        :category => Category.create(:name => 'test'), :published_date => '2012-03-11', :author => 'Test'
        
    @article = Article.create :title => 'My showed article test', :body => 'The body of the test article',
         :category => Category.first, :published_date => '2012-03-11', :published => true, :author => 'Test'
         
    @user = User.create :email => 'test@test.com', :username => 'test_user', :password => '123456'
  end
  
  describe "Home" do
    
    describe "general" do
      it "should load the principal page" do
        visit '/'
        assert page.has_content?('News').must_be_same_as true
      end
      
      it "should load the admin page" do
        visit '/admin'
        assert page.has_content?('Pdigital Login').must_be_same_as true
      end
      
      it "should do login in the admin page" do
        AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
        visit '/admin/login'
        fill_in('admin_user_email', :with => 'admin@example.com')
        fill_in('admin_user_password', :with => 'password')
        click_on('admin_user_submit')
        assert page.has_content?('Dashboard').must_be_same_as true
      end
      
    end
    
    describe "UserActions" do
    
      it "should write a comment" do
        visit '/articles/my-showed-article-test' 
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456') 
        click_on('signin_button') 
        fill_in('article_comment_comment', :with => 'Test comment :D') 
        click_on('Send')
        assert ArticleComment.first.comment.must_equal('Test comment :D')
      end
      
      it "shouldn't write a comment" do
        visit '/articles/my-showed-article-test'
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456')
        click_on('signin_button')
        fill_in('article_comment_comment', :with => '')
        click_on('Send')
        assert ArticleComment.first.must_be_nil true
      end
      
      it "should vote a comment" do
        visit '/articles/my-showed-article-test'
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456')
        click_on('signin_button')
        fill_in('article_comment_comment', :with => 'Test comment :D')
        click_on('Send')
        click_on('Vote Ok')
        assert Vote.first.vote_type.must_equal(1)
      end
      
      it "shouldn't vote a comment" do
        visit '/articles/my-showed-article-test'
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456')
        click_on('signin_button')
        fill_in('article_comment_comment', :with => 'Test comment :D')
        click_on('Send')
        click_on('Vote Ok')
        visit '/articles/my-showed-article-test'
        
        assert page.has_content?('Voted').must_be_same_as true
      end  
      
      it "should vote a poll" do
        poll = Poll.create :question => "Test poll"
        PollOption.create :poll => poll, :option => "Option Test"
        visit '/articles/my-showed-article-test'
        click_on('Option Test')
        PollVote.first.poll_id.must_equal(1)
      end    
    end
    
    describe "Published" do
      it "shouldn't show the article if not published" do
        visit '/'
        assert page.has_content?('My article test').must_be_same_as false
      end

      it "should show the article if its published" do
        visit '/'
        assert page.has_content?('My showed article test').must_be_same_as true
      end
    end
  end
end
