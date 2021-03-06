require "minitest_helper"

describe "Articles integration" do
  before :each do
    @article_non = Article.create :title => 'My non showed article test', :body => 'The body of the test article', 
        :category => Category.create(:name => 'test'), :published_date => '2012-03-11', :author => 'Test'
        
    @article = Article.create :title => 'My showed article test', :body => 'The body of the test article',
         :category => Category.first, :published_date => '2012-03-11', :active => true, :author => 'Test'
         
    @user = User.create :email => 'test@test.com', :username => 'test_user', :password => '123456', :password_confirmation => '123456'
    @user.confirm!

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
      
      it "shouldn't do login in the admin page" do
        AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
        visit '/admin/login'
        fill_in('admin_user_email', :with => 'admin@example.com')
        fill_in('admin_user_password', :with => '')
        click_on('admin_user_submit')
        assert page.has_content?('Dashboard').must_be_same_as false
      end
      
      it "should do login in the web" do
        visit '/articles/my-showed-article-test' 
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456') 
        click_on('devise_button') 
        puts page
        assert page.has_content?('Welcome, test_user').must_be_same_as true
      end
      
    end
    
    describe "UserActions" do
    
      it "should write a comment" do
        visit '/articles/my-showed-article-test' 
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456') 
        click_on('devise_button') 
        fill_in('comment_body', :with => 'Test comment :D') 
        click_on('Send')
        assert Comment.first.body.must_equal('Test comment :D')
      end
      
      it "shouldn't write a comment" do
        visit '/articles/my-showed-article-test'
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456')
        click_on('devise_button')
        fill_in('comment_body', :with => '')
        click_on('Send')
        assert Comment.first.must_be_nil true
      end
      
      it "should vote a comment" do
        visit '/articles/my-showed-article-test'
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456')
        click_on('devise_button')
        fill_in('comment_body', :with => 'Test comment :D')
        click_on('Send')
        click_on('Vote Ok')
        assert Vote.first.vote_type.must_equal(1)
      end
      
      it "shouldn't vote a comment" do
        visit '/articles/my-showed-article-test'
        click_link('Sign In')
        fill_in('user_email', :with => 'test@test.com')
        fill_in('user_password', :with => '123456')
        click_on('devise_button')
        fill_in('comment_body', :with => 'Test comment :D')
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
    
    describe "Search Page" do
    
      it "should load the page directly" do
        visit '/search'
        assert page.has_content?('Search').must_be_same_as true
      end
      
      it "should load the page without params" do
        visit '/'
        click_on('Search')
        assert page.has_content?('Search').must_be_same_as true
      end
      
      it "should search an article" do
        visit '/'
        fill_in('search', :with => 'showed article')
        click_on('Search')
        
        assert page.has_content?('My showed article test').must_be_same_as true
      end
      
      it "should search an article with small word" do
        visit '/'
        fill_in('search', :with => 'a-d')
        click_on('Search')
        
        assert page.has_content?('Search').must_be_same_as true
      end
      
      it "should search an article with large word" do
        visit '/'
        fill_in('search', :with => 'sdbsadh78yd78hiunsdsdsafdfs-fdf,dsf')
        click_on('Search')
        
        assert page.has_content?('Search').must_be_same_as true
      end
    end
    
    describe "GET RSS feed" do
      it "returns an RSS feed" do
        visit '/rss.xml'
        assert page.has_content?('body of the test').must_be_same_as true
      end
    end
    
  end
end
