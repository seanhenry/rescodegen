
module Rescodegen

    class KeyGenerator

        attr_reader :key_reader
        attr_reader :code_safe_key_generator
        attr_reader :file_path

        def initialize(key_reader, code_safe_key_generator, file_path)
            @key_reader = key_reader
            @code_safe_key_generator = code_safe_key_generator
            @file_path = file_path
        end

        def keys
            key_reader.read_keys_from_lines File.open(file_path, "rb:UTF-16BE")
        end

        def code_safe_keys
            code_safe_key_generator.code_safe_keys_from_keys keys
        end
    end
end
