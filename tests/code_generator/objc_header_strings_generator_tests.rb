require 'minitest/autorun'
require './lib/code_generator/objc_header_strings_generator'

class ObjcHeaderStringsGeneratorTests < Minitest::Test

	def test_generate_raises_exception_when_keys_and_values_are_different_sizes
		assert_raises RuntimeError do 
			ObjcHeaderStringsGenerator.new.generate([""], ["", ""])
		end 
	end

	def test_generate_generates_empty_enum_when_no_keys_or_values
		assert_true file_is_generated_by_keys_values("empty_enum.h", [], [])
	end

	def test_generate_generates_many_cases_when_keys_and_values
		assert_true file_is_generated_by_keys_values("two_case_enum.h", ["key1", "key2"], ["value1", "value2"])
	end

	def file_is_generated_by_keys_values(file_name, keys, values)
		ObjcHeaderStringsGenerator.new.generate [""], [""]
		generated_code = ObjcHeaderStringsGenerator.new.generate(keys, values).split("\n")
		expected_file = file_lines file_name
		if expected_file.size != generated_code.size 
			handle_unequal_line_counts(expected_file, generated_code)
			return false
		end
		i = 0
		while i < expected_file.count do
			if expected_file[i] != generated_code[i]
				handle_unequal_lines_at(expected_file, generated_code, i)
				return false
			end
			i += 1
		end
		true
	end

	def file_lines(file_name)
		file_path = Dir.pwd + "/tests/code_generator/" + file_name
		File.readlines(file_path).map do |line|
			line.gsub(/\n/, "")
		end
	end

	def handle_unequal_line_counts(expected_file, generated_code)
		puts "Expected line count #{expected_file.size}, got #{generated_code.size}"
		puts "Generated lines:\n" + print_lines(generated_code)
		puts "Expected lines: \n" + print_lines(expected_file)
	end

	def handle_unequal_lines_at(expected_file, generated_code, index)
		puts "Expected line #{expected_file[index]} got: #{generated_code[index]}"
		puts "Line number: #{index + 1}"
		puts "Generated lines:\n" + print_lines(generated_code)
		puts "Expected lines: \n" + print_lines(expected_file)
	end

	def print_lines lines 
		lines.join("\n")
	end

	def assert_true(condition)
		assert_equal(true, condition)
	end
end
