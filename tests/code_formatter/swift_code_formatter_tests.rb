require 'minitest/autorun'
require './lib/code_formatter/swift_code_formatter'

class SwiftCodeFormatterTests < Minitest::Test

	def test_format_string_should_make_first_character_lower_case
		assert_equal "lowerCase", formatter.format_string("LowerCase")
	end

	def test_format_string_should_make_first_character_after_underscore_lower_case
		assert_equal "lower_case_string", formatter.format_string("Lower_Case_String")
	end

	def test_format_string_should_not_make_acronyms_lower_case
		assert_equal "URL_test_HTTPAccess", formatter.format_string("URL_Test_HTTPAccess")
	end

	def formatter
		SwiftCodeFormatter.new
	end
end
