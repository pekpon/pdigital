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
  end


end