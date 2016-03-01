require 'test_helper'
require 'rescodegen/key_generator/strings_key_generator'

class StringsKeyGeneratorTests < Minitest::Test

    def test_create_from_file_should_handle_UTF_16
        generator = Rescodegen::StringsKeyGenerator.create_from_file(Dir.pwd + "/test/key_generator/test.strings")
        assert_equal ["Key 1", "Key 2"], generator.keys
    end

    def test_keys_generates_keys
        assert_equal ["key"], code_safe_keys_with_key("key")
    end

    def test_keys_generates_multiple_keys
        keys = ["key 1", "another key", "some %d value"]
        assert_equal keys, keys_with_keys(keys)
    end

    def test_keys_should_handle_newlines
        newline = ["new\\nline"]
        assert_equal newline, keys_with_keys(newline)
    end

    def test_keys_should_handle_UTF_16
        utf16 = "\"key\" = \"value\";".encode("UTF-16")
        generator = Rescodegen::StringsKeyGenerator.new [utf16]
        assert_equal ["key"], generator.keys
    end

    def test_code_safe_keys_should_escape_percent_value_at_end
        assert_equal ["key"], code_safe_keys_with_key("key %d")
    end

    def test_code_safe_keys_should_esacpe_percent_values_at_beginning
        assert_equal ["key"], code_safe_keys_with_key("%d key")
    end

    def test_code_safe_keys_should_esacpe_percent_values_in_middle
        assert_equal ["key_key"], code_safe_keys_with_key("key %d key")
    end

    def test_code_safe_keys_should_replace_spaces_with_underscores
        assert_equal ["key_with_spaces"], code_safe_keys_with_key("key with spaces")
    end

    def test_code_safe_keys_should_replace_spaces_at_beginning_and_end
        assert_equal ["key"], code_safe_keys_with_key("    key   ")
    end

    def test_code_safe_keys_should_replace_special_characters
        assert_equal ["key_with_special_characters_t_e_s_t_i_n_g"], code_safe_keys_with_key("key:with.special-characters;t(e)s*t,i!n£g")
    end

    def test_code_safe_keys_should_add_underscore_when_number_at_beginning
        assert_equal ["_3_keys"], code_safe_keys_with_key("3 keys")
    end

    def test_code_safe_keys_should_maintain_case
        assert_equal ["SOME_MixED_cAse_Key"], code_safe_keys_with_key("SOME MixED cAse Key")
    end

    def test_code_safe_keys_should_not_have_multi_underscores
        assert_equal ["key_key"], code_safe_keys_with_key("key &&== key")
    end

    def test_code_safe_keys_should_replace_percent_ld
        assert_equal ["key_key"], code_safe_keys_with_key("key %ld key")
    end

    def test_code_safe_keys_should_replace_percent_with_decimal
        assert_equal ["key_key"], code_safe_keys_with_key("key %.2f key")
    end

    def code_safe_keys_with_key key
        lines = StringsBuilder.new.add_comment_key("comment", key).build
        generator = Rescodegen::StringsKeyGenerator.new lines
        generator.code_safe_keys
    end

    def keys_with_key key
        lines = StringsBuilder.new.add_comment_key("comment", key).build
        generator = Rescodegen::StringsKeyGenerator.new lines
        generator.keys
    end

    def keys_with_keys keys
        builder = StringsBuilder.new
        keys.each { |key| builder.add_comment_key("comment", key) }
        lines = builder.build
        generator = Rescodegen::StringsKeyGenerator.new lines
        generator.keys
    end
end

class StringsBuilder

    def initialize
        @lines = Array.new
    end

    def add_comment_key comment, key
        @lines += ["/* #{comment} */", "\"#{key}\" = \"Description\""]
        self
    end

    def build
        @lines
    end
end
