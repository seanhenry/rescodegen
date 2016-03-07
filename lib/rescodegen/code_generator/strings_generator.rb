
module Rescodegen
    class StringsGenerator

        def generate(singular_keys, singular_values, plural_keys, plural_values)
            raise "Expects keys and values of equal sizes" if singular_keys.size != singular_values.size || plural_keys.size != plural_values.size
            raise "Expects at least one key and one value" if singular_keys.size == 0 && plural_keys.size == 0
            @output = ""
            @tab_level = 0
        end

    protected

        def prefix(string)
            @prefix + string
        end

        def newline
            @output += "\n"
            self
        end

        def open_brackets
            @output += " {"
            newline
            increment_indent_level
        end

        def close_brackets
            decrement_indent_level
            indent
            @output += "}"
            newline
        end

        def increment_indent_level
            @tab_level += 1
            self
        end

        def decrement_indent_level
            @tab_level -= 1
            self
        end

        def indent
            @output += (1..@tab_level).reduce("") { |a, b| a + tab }
            self
        end

        def tab
            "    "
        end
    end
end
