require "minitest_helper"

describe ArticleComment do
  ## Testing Comment votes validations
  describe 'validate' do

    before :each do
      @article = Article.create! :category => Category.create(:name => 'test'), :body => 'Esto es un body', :title => 'aun menos', 
        :published_date => Time.now
      @user = User.create(:username => 'test', :email => 'a@a.com', :password => '123456')
    end
    
    
    describe 'fields' do
      
      it 'should not create a comment' do
        comment = @article.article_comments.create
        assert comment.id.must_be_nil
      end
      
      it 'should not create a comment with comment field empty' do
        comment = @article.article_comments.create :user => @user, :comment => '', :username => 'test_user'
        assert comment.id.must_be_nil
      end
      
      it 'should not create a comment less 2 character' do
        comment = @article.article_comments.create :user => @user, :comment => 'x', :username => 'test_user'
        assert comment.id.must_be_nil
      end
      
      it 'should not create a comment duplicated' do
        comment = @article.article_comments.create :user => @user, :comment => 'xx', :username => 'test_user'
        comment2 = @article.article_comments.create :user => @user, :comment => 'xx', :username => 'test_user'
        assert comment2.id.must_be_nil
      end

      it 'should create a comment with user' do
        skip 'On hold error with wont_be_nil'
        comment = @article.article_comments.create :user => @user, :comment => 'gagagag'
        puts comment.inspect
        assert comment.id.wont_be_nil
      end
      
      it 'should create a comment with username' do
        comment = @article.article_comments.create :user => nil, :comment => 'xxx', :username => 'test_user'
        assert comment.id.must_be :>, 0
      end
      
    end
    
    describe 'votes' do
      
      it 'should not vote a comment' do
        skip
        comment = @article.article_comments.create :user => nil, :comment => 'xxxxx', :username => 'test_user'
        vote = comment.vote.create(1,"1.1.1.1")
        vote2 = comment.vote(1,"1.1.1.1")
        assert vote2.id.must_be_nil
      end
      
       it 'should be voted' do
         comment = @article.article_comments.create :user => nil, :comment => 'xxxxx', :username => 'test_user'
         comment.vote(1, "1.1.1.1")
          assert comment.voted "1.1.1.1"
        end
      
    end

  end
  
end
