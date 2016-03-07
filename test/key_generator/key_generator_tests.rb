require 'test_helper.rb'
require 'rescodegen/key_generator/key_generator'
require 'rescodegen/key_generator/code_safe_key_generator'
require 'rescodegen/key_reader/strings_key_reader'

class KeyGeneratorTests < Minitest::Test

    def test_keys_should_return_keys_from_UTF8
        assert_equal ["Key 1", "Key 2"], generator_with_UTF8_encoding.keys
    end

    def test_code_safe_keys_should_return_keys_from_UTF8
        assert_equal ["Key_1", "Key_2"], generator_with_UTF8_encoding.code_safe_keys
    end

    def test_keys_should_return_keys_from_UTF16
        assert_equal ["Key 1", "Key 2"], generator_with_UTF16_encoding.keys
    end

    def test_keys_should_raise_exception_when_using_unknown_encoding
        assert_raises RuntimeError do
            generator_with_encoding(:unknown, "test8.strings").keys
        end
    end

    def test_code_safe_keys_should_return_keys_from_UTF16
        assert_equal ["Key_1", "Key_2"], generator_with_UTF16_encoding.code_safe_keys
    end

    def generator_with_UTF8_encoding
        generator_with_encoding(:utf8, "test8.strings")
    end

    def generator_with_UTF16_encoding
        generator_with_encoding(:utf16, "test16.strings")
    end

    def generator_with_encoding(encoding, file_path)
        reader = Rescodegen::StringsKeyReader.new
        code_safe_generator = Rescodegen::CodeSafeKeyGenerator.new 
        file_path = Dir.pwd + "/test/key_generator/#{file_path}"
        Rescodegen::KeyGenerator.new(reader, code_safe_generator, file_path, encoding)
    end
end
