require 'test_helper'
require 'rescodegen/key_generator/code_safe_key_generator'

class CodeSafeKeyGeneratorTests < Minitest::Test

    def test_code_safe_keys_from_keys_should_escape_percent_value_at_end
        assert_equal ["key"], code_safe_keys_from_keys_with_key("key %d")
    end

    def test_code_safe_keys_from_keys_should_esacpe_percent_values_at_beginning
        assert_equal ["key"], code_safe_keys_from_keys_with_key("%d key")
    end

    def test_code_safe_keys_from_keys_should_esacpe_percent_values_in_middle
        assert_equal ["key_key"], code_safe_keys_from_keys_with_key("key %d key")
    end

    def test_code_safe_keys_from_keys_should_replace_spaces_with_underscores
        assert_equal ["key_with_spaces"], code_safe_keys_from_keys_with_key("key with spaces")
    end

    def test_code_safe_keys_from_keys_should_replace_spaces_at_beginning_and_end
        assert_equal ["key"], code_safe_keys_from_keys_with_key("    key   ")
    end

    def test_code_safe_keys_from_keys_should_replace_special_characters
        assert_equal ["key_with_special_characters_t_e_s_t_i_n_g"], code_safe_keys_from_keys_with_key("key:with.special-characters;t(e)s*t,i!n£g")
    end

    def test_code_safe_keys_from_keys_should_add_underscore_when_number_at_beginning
        assert_equal ["_3_keys"], code_safe_keys_from_keys_with_key("3 keys")
    end

    def test_code_safe_keys_from_keys_should_maintain_case
        assert_equal ["SOME_MixED_cAse_Key"], code_safe_keys_from_keys_with_key("SOME MixED cAse Key")
    end

    def test_code_safe_keys_from_keys_should_not_have_multi_underscores
        assert_equal ["key_key"], code_safe_keys_from_keys_with_key("key &&== key")
    end

    def test_code_safe_keys_from_keys_should_replace_percent_ld
        assert_equal ["key_key"], code_safe_keys_from_keys_with_key("key %ld key")
    end

    def test_code_safe_keys_from_keys_should_replace_percent_with_decimal
        assert_equal ["key_key"], code_safe_keys_from_keys_with_key("key %.2f key")
    end

    def code_safe_keys_from_keys_with_key key
        generator = Rescodegen::CodeSafeKeyGenerator.new 
        generator.code_safe_keys_from_keys [key]
    end
end
