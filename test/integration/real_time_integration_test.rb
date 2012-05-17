require "minitest_helper"

describe "Real Time integration" do
   describe "Real Time" do
     it "View the real time page" do
       visit '/real_time'
       assert page.has_content?('Real Time').must_be_same_as true
     end
   end
    
end