require 'test_helper'
require 'rescodegen/code_generator/objc_header_strings_generator'
require_relative 'code_generator_test_helper'

class ObjcHeaderStringsGeneratorTests < Minitest::Test

    def test_generate_generates_singular_cases
        assert_file_is_generated_by_keys_values("singular.h", ["key1", "key2"], ["value1", "value2"])
    end

    def test_generate_generates_singular_and_plural_cases
        file_is_generated_by_singular_and_plural_keys_and_values("singular_and_plural.h", ["key1", "key2"], ["value1", "value2"], ["key3", "key4"], ["value3", "value4"])
    end

    def test_generate_generates_plural_cases
        file_is_generated_by_singular_and_plural_keys_and_values("plural.h", [], [], ["key1", "key2"], ["value1", "value2"])
    end

    def assert_file_is_generated_by_keys_values(file_name, keys, values)
        generator = Rescodegen::ObjcHeaderStringsGenerator.new "SH"
        assert_equal(true, CodeGeneratorTestHelper.new.file_is_generated_by_keys_values(generator, file_name, keys, values))
    end

    def file_is_generated_by_singular_and_plural_keys_and_values(file_name, singular_keys, singular_values, plural_keys, plural_values)
        generator = Rescodegen::ObjcHeaderStringsGenerator.new "SH"
        assert_equal(true, CodeGeneratorTestHelper.new.file_is_generated_by_singular_and_plural_keys_and_values(generator, file_name, singular_keys, singular_values, plural_keys, plural_values))
    end
end
