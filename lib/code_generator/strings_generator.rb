
class StringsGenerator

    def generate(keys, values)
        raise "Expects keys and values of equal sizes" if keys.size != values.size
        @output = ""
        @tab_level = 0
    end

protected

    def newline
        @output += "\n"
        self
    end

    def open_brackets
        @output += " {"
        newline
        increment_indent_level
        self
    end

    def close_brackets
        decrement_indent_level
        indent
        @output += "}"
        newline
        self
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
