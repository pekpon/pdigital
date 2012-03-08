require "rake/testtask"

Rake::TestTask.new(:test => "db:test:prepare") do |t|
#Rake::TestTask.new(:test) do |t|
 t.libs << "test"
 t.pattern = "test/**/*_test.rb"
end


#desc "testing"
#task :test => :environment do
#  %w(create migrate test:prepare).each do |task|
#    puts "Performing task #{task}"
#    #Some logic could go here
#    Rake::Task["db:#{task}"].invoke 
#  end
#end

task :default => :test
