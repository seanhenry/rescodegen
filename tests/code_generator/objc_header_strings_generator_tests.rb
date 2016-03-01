require 'minitest/autorun'
require './lib/code_generator/objc_header_strings_generator'
require './tests/code_generator/code_generator_test_helper'

class ObjcHeaderStringsGeneratorTests < Minitest::Test

    def test_generate_raises_exception_when_keys_and_values_are_different_sizes
        assert_raises RuntimeError do 
            ObjcHeaderStringsGenerator.new.generate([""], ["", ""])
        end 
    end

    def test_generate_generates_empty_enum_when_no_keys_or_values
        assert_file_is_generated_by_keys_values("empty_enum.h", [], [])
    end

    def test_generate_generates_many_cases_when_keys_and_values
        assert_file_is_generated_by_keys_values("two_case_enum.h", ["Key1", "Key2"], ["value1", "value2"])
    end

    def assert_file_is_generated_by_keys_values(file_name, keys, values)
        assert_equal(true, CodeGeneratorTestHelper.new.file_is_generated_by_keys_values(ObjcHeaderStringsGenerator.new, file_name, keys, values))
    end
end
