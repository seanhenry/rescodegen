
module Rescodegen
                 
    class CodeSafeKeyGenerator

        def code_safe_keys_from_keys(keys)
            keys.map { |key|
                key.replace_string_format_specifiers
                .replace_unsupported_characters
                .replace_whitespace
                .remove_duplicate_underscores
                .trim_underscores
                .protect_from_numbers
            }
        end
    end
end

private
    class String
        def replace_string_format_specifiers
            gsub(/%\.[0-9]f|%[a-zA-Z@]+/, "_")
        end

        def replace_unsupported_characters
            gsub(/[^a-zA-Z0-9]/, "_")
        end

        def replace_whitespace
            gsub(/\s+/, "_")
        end

        def remove_duplicate_underscores
            gsub(/_+/, "_")
        end

        def trim_underscores
            gsub(/^_|_$/, "")
        end

        def protect_from_numbers
            sub(/(^[0-9])/, "_\\1")
        end
    end
