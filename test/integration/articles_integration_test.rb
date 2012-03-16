require "minitest_helper"

describe "Articles integration" do
  before :each do
    @article = Article.create :title => 'My article test', :body => 'The body of the test article', 
        :category => Category.create(:name => 'test'), :published_date => '2012-03-11'
  end
  
  describe "Home" do
    
    describe "general" do
      it "should load the principal page" do
        visit '/'
        assert page.has_content?('News').must_be_same_as true
      end
      
      it "should load the admin page" do
        skip
        visit '/admin'
        fill_in('Email', :with => 'admin@example.com')
        fill_in('Password', :with => 'password')
        click_button('Login')
        
        assert current_path.must_be_same_as '/admin/article_comments'
      end
      
    end
    
    describe "Published" do
      it "shouldn't show the article if not published" do
        visit '/'
        assert page.has_content?('My article test').must_be_same_as false
      end

      it "should show the article if its published" do
        @article = Article.create :title => 'My article test', :body => 'The body of the test article',
         :category => Category.first, :published_date => '2012-03-11', :published => true
        visit '/'
        assert page.has_content?('My article test').must_be_same_as true
      end
    end
  end
end
