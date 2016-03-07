require 'test_helper'
require 'rescodegen/key_reader/stringsdict_key_reader'
require 'plist'

class StringsdictKeyReaderTests < Minitest::Test

    def test_read_keys_from_lines_should_generate_key
        array = ["key 1"]
        assert_equal array, read_keys_from_keys(array)
    end

    def test_read_keys_from_lines_should_generate_keys
        array = ["key 1", "key 2"]
        assert_equal array, read_keys_from_keys(array)
    end

    def test_read_keys_from_lines_should_handle_special_characters
        array = ["%d %lu"]
        assert_equal array, read_keys_from_keys(array)
    end

    def test_read_keys_from_lines_should_raise_exception_when_invalid_plist_file
        assert_raises RuntimeError do 
            StringsdictKeyReader.new.read_keys_from_lines ["not a plist file"]
        end 
    end

    def read_keys_from_keys(keys)
        lines = plist_entry_for_keys(keys)
        StringsdictKeyReader.new.read_keys_from_lines lines
    end

    def plist_entry_for_keys(keys)
        hash = Hash.new
        keys.each { |k| hash[k] = plist_entry }
        hash.to_plist.split("\n")
    end

    def plist_entry
        { :NSStringLocalizedFormatKey => "format_key",
            :format => {
                :NSStringFormatSpecTypeKey => "NSStringPluralRuleType",
                :NSStringFormatValueTypeKey => "d",
                :one => "One format",
                :other => "%d formats" 
            }
        }
    end
end
