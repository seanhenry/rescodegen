require 'test_helper'
require 'rescodegen/key_reader/strings_key_reader'

class StringsKeyReaderTests < Minitest::Test

    def test_read_keys_from_lines_generates_keys
        assert_equal ["key"], read_keys_from_lines(["key"])
    end

    def test_read_keys_from_lines_generates_multiple_keys
        keys = ["key 1", "another key", "some %d value"]
        assert_equal keys, read_keys_from_lines(keys)
    end

    def test_read_keys_from_lines_should_handle_newlines
        newline = ['new\nline']
        assert_equal newline, read_keys_from_lines(newline)
    end

    def test_read_keys_from_lines_should_handle_UTF_16
        utf16 = "\"key\" = \"value\";".encode("UTF-16")
        assert_equal ["key"], Rescodegen::StringsKeyReader.new.read_keys_from_lines([utf16])
    end

    def read_keys_from_lines(keys)
        lines = keys.reduce([]) { |lines, key|
            lines.push "/* Some comment */" + "\n"
            lines.push surround_with_quotes(key) + " = " + surround_with_quotes("value") + "\n"
            lines.push "\n"
        }
        Rescodegen::StringsKeyReader.new.read_keys_from_lines lines
    end

    def surround_with_quotes(value)
        "\"" + value + "\""
    end
end
