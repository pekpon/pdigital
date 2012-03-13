require "minitest_helper"

describe Article do
  
  ## Testing Articles validations
  describe 'validations' do
    
      describe 'fields' do
    
      it 'should fail' do
        article = Article.create
        [:category, :body, :title, :published_date].each do |key|
          assert article.errors.messages.has_key? key
        end
      end
      
      it 'should create an article' do
        article = Article.create :title => 'My article test', :body => 'The body of the test article', 
        :category => Category.create(:name => 'test'), :published_date => '2012-03-11'
        assert article.id.must_be :>, 0
      end
      
      it 'should fail because it have wrong format publish_date' do
        article = Article.create :title => 'Ho', :body => 'test body', :category => Category.create(:name => 'test'),
         :published_date => '2012-3-11'
         
        assert article.id.must_be_nil
      end
      
      it 'should fail because it have long subtitle' do
        article = Article.create :title => 'Ho', :body => 'test body', :category => Category.create(:name => 'test'),
         :published_date => '2012-3-11', :subtitle => 'abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk abcdefghijk '
         
        assert article.id.must_be_nil
      end
    
      it 'should fail because it have less than 3 characters on title' do
        article = Article.create :title => 'Ho', :body => 'test body', :category => Category.create(:name => 'test'),
         :published_date => Time.now
         
        assert article.id.must_be_nil
      end
      
      it 'should fail because it have less than 10 characters on body' do
        article = Article.create :title => 'Hola', :body => 'test body', :category => Category.create(:name => 'test'),
         :published_date => Time.now
         
        assert article.id.must_be_nil
      end
      
      describe 'Friendly_id' do
        it 'should create a slug' do
          article = Article.create :title => 'Hola', :body => 'test bodyaaaaa', :category => Category.create(:name => 'test'),
            :published_date => Time.now
         
          assert article.slug.blank?.must_equal false
        end

        it 'should not change the slug when passing one' do
          article = Article.create :title => 'Hola', :body => 'test bodyaaaaa', :category => Category.create(:name => 'test'),
            :published_date => Time.now, :slug => 'test'
         
          assert article.slug.must_equal 'test'
        end

        it 'should not change the slug when saving an existing object' do
          article = Article.create :title => 'Hola', :body => 'test bodyaaaaa', :category => Category.create(:name => 'test'),
            :published_date => Time.now, :slug => 'test'
          article.slug = 'test1'
          article.save
          
          assert article.slug.must_equal 'test1'
        end

        
      end
      
    end
    
  end

end
