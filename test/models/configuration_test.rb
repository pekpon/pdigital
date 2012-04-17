require "minitest_helper"

describe Configuration do
  
  ## Testing Articles validations
  describe 'search by key' do
    it 'should give me the value of a key' do
      value_to_test = "testing config"
      Configuration.create(:key => :test, :values => value_to_test)
      assert Configuration.value(:test) == value_to_test
    end

    it 'should not give me the value of a key' do
      assert Configuration.value(:testo) == nil
    end
    
  end


end
