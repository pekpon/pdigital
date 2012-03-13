require "minitest_helper"

describe User do
  
  ## Testing Users validations
  describe 'validations' do
    it 'should fail' do
      user = User.create
      [:username, :email, :password].each do |key|
        assert user.errors.messages.has_key? key
      end
    end
    
    it 'should create and User' do
      user = User.create :username => 'paco', :email => 'asdsadsa@sdasda.com', :password => '123456'
      assert user.id.must_be :>,0
    end
    
    it 'should fail because username short' do
      user = User.create :username => 'a', :email => 'a@a.com', :password => '123456'
      assert user.id.must_be_nil
    end
  
    it 'should fail because password short' do
      user = User.create :username => 'asdf', :email => 'a@a.com', :password => '123'
      assert user.id.must_be_nil
    end
        
    it 'should fail because email uniqueness' do
      user = User.create :username => 'asdfx', :email => 'a@a.com', :password => '123456'
      user2 = User.create :username => 'asdfdx', :email => 'a@a.com', :password => '123456'
      assert user2.id.must_be_nil
    end
    
    it 'should fail because username uniqueness' do
      user = User.create! :username => 'asdfd', :email => 'as@a.com', :password => '123456'
      user2 = User.create :username => 'asdfd', :email => 'aa@a.com', :password => '123456'
      assert user2.id.must_be_nil
    end
    
  end


end