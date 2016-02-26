require 'rake/testtask'

Rake::TestTask.new do |t|
	t.pattern = "tests/**/*tests.rb"
end

task :run do
	ARGV.delete_at(0)
	args = ARGV.reduce("") { |a, b| a + " " + b }
	puts `ruby lib/GenerateStrings.rb #{args}` 
end

task :default => :test
