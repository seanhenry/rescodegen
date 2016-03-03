require 'test_helper.rb'
require 'rescodegen/key_generator/key_generator'
require 'rescodegen/key_generator/code_safe_key_generator'
require 'rescodegen/key_reader/strings_key_reader'

class KeyGeneratorTests < Minitest::Test

    def test_keys_should_return_keys
        assert_equal ["Key 1", "Key 2"], generator.keys
    end

    def test_code_safe_keys_should_return_keys
        assert_equal ["Key_1", "Key_2"], generator.code_safe_keys
    end

    def generator
        return @generator if @generator != nil
        reader = Rescodegen::StringsKeyReader.new
        code_safe_generator = Rescodegen::CodeSafeKeyGenerator.new 
        file_path = Dir.pwd + "/test/key_generator/test.strings"
        @generator = Rescodegen::KeyGenerator.new(reader, code_safe_generator, file_path)
    end
end
