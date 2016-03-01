require 'minitest/autorun'
require './lib/code_formatter/objc_code_formatter'

class ObjcCodeFormatterTests < Minitest::Test

	def test_format_string_should_capitalise_first_character
		assert_equal "UpperCase", formatter.format_string("upperCase")
	end

	def test_format_string_should_make_first_character_after_underscore_lower_case
		assert_equal "Upper_case_string", formatter.format_string("upper_Case_String")
	end

	def test_format_string_should_not_make_acronyms_lower_case
		assert_equal "URL_test_HTTPAccess", formatter.format_string("URL_Test_HTTPAccess")
	end

	def formatter
		ObjcCodeFormatter.new
	end
end
