require 'test_helper'
require 'rescodegen/code_generator/objc_main_strings_generator'
require_relative 'code_generator_test_helper'

class ObjcMainStringsGeneratorTests < Minitest::Test

    def test_generate_generates_many_cases_when_keys_and_values
        assert_file_is_generated_by_keys_values("singular.m", ["key1", "key2"], ["value1", "value2"])
    end

    def assert_file_is_generated_by_keys_values(file_name, keys, values)
        generator = Rescodegen::ObjcMainStringsGenerator.new "SH"
        assert_equal(true, CodeGeneratorTestHelper.new.file_is_generated_by_keys_values(generator, file_name, keys, values))
    end
end
