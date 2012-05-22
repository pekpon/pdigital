require "minitest_helper"

describe Comment do
  ## Testing Comment votes validations
  describe 'validate' do

    before :each do
      @article = Article.create! :category => Category.create(:name => 'test'), :body => 'Esto es un body', :title => 'aun menos', 
        :published_date => Time.now
      @user = User.create(:username => 'test', :email => 'a@a.com', :password => '123456')
    end
    
    
    describe 'fields' do
      
      it 'should not create a comment' do
        comment = @article.comments.create
        assert comment.id.must_be_nil
      end
      
      it 'should not create a comment with comment field empty' do
        comment = @article.comments.create :user => @user, :body => '', :username => 'test_user'
        assert comment.id.must_be_nil
      end
      
      it 'should not create a comment less 2 character' do
        comment = @article.comments.create :user => @user, :body => 'x', :username => 'test_user'
        assert comment.id.must_be_nil
      end
      
      it 'should not create a comment duplicated' do
        comment = @article.comments.create :user => @user, :body => 'xx', :username => 'test_user'
        comment2 = @article.comments.create :user => @user, :body => 'xx', :username => 'test_user'
        assert comment2.id.must_be_nil
      end

      it 'should create a comment with user' do
        comment = @article.comments.create :user => @user, :body => 'gagagag'
        puts comment.inspect
        assert comment.id.must_be :>, 0
      end
      
      it 'should create a comment with username' do
        comment = @article.comments.create :user => nil, :body => 'xxx', :username => 'test_user'
        assert comment.id.must_be :>, 0
      end
      
    end
    
    describe 'votes' do
      
      it 'should not vote a comment' do
        comment = @article.comments.create :user => nil, :body => 'xxxxx', :username => 'test_user'
        vote = comment.vote(1,"1.1.1.1")
        assert lambda { comment.vote(1,"1.1.1.1") }.must_raise(ActiveRecord::RecordInvalid)
      end
      
       it 'should be voted' do
         comment = @article.comments.create :user => nil, :body => 'xxxxx', :username => 'test_user'
         comment.vote(1, "1.1.1.1")
          assert comment.voted "1.1.1.1"
        end
      
    end

  end
  
end
