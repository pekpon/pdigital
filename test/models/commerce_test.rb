require "minitest_helper"

describe Commerce do
  
  ## Testing Commerces validations
  describe 'validations' do
    
      describe 'fields' do
    
        it 'should fail' do
          commerce = Commerce.create
          [:name, :street, :telephone].each do |key|
            assert commerce.errors.messages.has_key? key
          end
        end
      
        it 'should create a commerce' do
          commerce = Commerce.create :name => 'Peach Pool', :street => '5th Street', :telephone => "666555444"
          assert commerce.id.must_be :>, 0
        end
      
        it 'should fail because it have a long telephone, more than 15 chr.' do
          commerce = Commerce.create :name => 'Peach Pool', :street => '5th Street', :telephone => "666555444333222111000999888"
          assert commerce.id.must_be_nil
        end
        
      end
      
    end
    
  end