#! /usr/bin/env ruby
require 'optparse'
require './lib/code_generator/swift_strings_generator'
require './lib/code_generator/objc_header_strings_generator'
require './lib/code_generator/objc_main_strings_generator'
require './lib/key_generator/strings_key_generator'

options = { output: ".", language: "swift" }

parser = OptionParser.new do |opts|
	opts.banner = "Usage: rescodegen [options] input_file"
	opts.separator "Generates some strings"
	opts.separator "Options:"
	opts.on("-l", "--language=swift|objc", "swift or objc") do |l|
		options[:language] = l
	end
	opts.on("-o", "--output=directory", "Directory to create file.") do |o|
		options[:output] = o
	end
end
parser.parse!

abort "Invalid -l argument. Expects swift or objc." if !options[:language].match("swift|objc")
input_file = ARGV.last
abort "Missing input_file.\n\n#{parser.help}" if input_file.nil?
output_file = options[:output] + "/Strings"

def generate_swift_file(code_safe_keys, keys, output_file)
	File.write(output_file + ".swift", SwiftStringsGenerator.new.generate(code_safe_keys, keys))
end

def generate_objc_files(code_safe_keys, keys, output_file)
	File.write(output_file + ".h", ObjcHeaderStringsGenerator.new.generate(code_safe_keys, keys))
	File.write(output_file + ".m", ObjcMainStringsGenerator.new.generate(code_safe_keys, keys))
end

generator = StringsKeyGenerator.new(File.readlines(input_file))
keys = generator.keys
code_safe_keys = generator.code_safe_keys
generate_swift_file(code_safe_keys, keys, output_file) if options[:language] == "swift"
generate_objc_files(code_safe_keys, keys, output_file) if options[:language] == "objc"


