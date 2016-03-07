require 'test_helper'
require 'rescodegen/code_generator/strings_generator'

class StringsGeneratorTests < Minitest::Test

    def test_generate_raises_exception_when_no_keys_or_values_exist
        assert_raises RuntimeError do
            Rescodegen::StringsGenerator.new.generate([], [], [], [])
        end
    end

    def test_generate_raises_exception_when_keys_and_values_are_different_sizes
        assert_raises RuntimeError do 
            Rescodegen::StringsGenerator.new.generate([""], ["", ""], [], [])
        end 
    end

    def test_generate_raises_exception_when_plural_keys_and_values_are_different_sizes
        assert_raises RuntimeError do 
            Rescodegen::StringsGenerator.new.generate([""], [""], [], [""])
        end 
    end
end
