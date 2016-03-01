require 'rake/testtask'

Rake::TestTask.new do |t|
	t.pattern = "tests/**/*tests.rb"
end

task :gen_swift, [:input] do |t, args|
	puts `ruby lib/rescodegen.rb -l swift #{args[:input]}`
end

task :gen_objc, [:input] do |t, args|
	puts `ruby lib/rescodegen.rb -l objc #{args[:input]}`
end

task :default => :test
