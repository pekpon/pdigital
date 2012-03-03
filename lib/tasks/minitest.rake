require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  %w(create migrate test:prepare).each do |task|
    puts "Performing task #{task}"
    #Some logic could go here
    Rake::Task["db:#{task}"].invoke 
  end

  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end




task :default => :test
