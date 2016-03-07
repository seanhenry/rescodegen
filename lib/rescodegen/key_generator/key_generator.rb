
module Rescodegen

    class KeyGenerator

        attr_reader :key_reader
        attr_reader :code_safe_key_generator
        attr_reader :file_path
        attr_reader :encoding

        def initialize(key_reader, code_safe_key_generator, file_path, encoding)
            @key_reader = key_reader
            @code_safe_key_generator = code_safe_key_generator
            @file_path = file_path
            @encoding = encoding
        end

        def keys
            if encoding == :utf16
                key_reader.read_keys_from_lines File.open(file_path, "rb:UTF-16BE")
            elsif encoding == :utf8
                key_reader.read_keys_from_lines File.open(file_path)
            else
                raise "Unsupported encoding #{encoding}. Expects utf8 or utf16."
            end 
        end

        def code_safe_keys
            code_safe_key_generator.code_safe_keys_from_keys keys
        end
    end
end
