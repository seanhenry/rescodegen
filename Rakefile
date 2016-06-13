require "bundler/gem_tasks"
require "rake/testtask"

task :test => [:unit, :acceptance] do 

end

Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList['test/**/*_tests.rb']
end

desc "Runs acceptance tests."
task :acceptance do 
    sh "bundle exec rspec spec"
end

task :default => :test
