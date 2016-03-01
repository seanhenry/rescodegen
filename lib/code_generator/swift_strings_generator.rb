require_relative 'strings_generator'

class SwiftStringsGenerator < StringsGenerator

    def generate(keys, values)
        super(keys, values)
        import_header("Foundation")
        start_struct("Strings")
            .start_enum("Singular", "String")
                .add_cases(keys, values)
                .start_computed_property("localizedString", "String")
                    .return_localized_string
                .close_brackets
            .close_brackets
        .close_brackets
        @output
    end

protected

    def newline
        @output += "\n"
        self
    end

    def import_header(name)
        @output += "import #{name}"
        newline.newline
        self
    end

    def start_struct(name)
        @output += "struct #{name}"
        open_brackets
        newline
        self
    end

    def start_enum(name, type)
        indent
        @output += "enum #{name}: #{type}"
        open_brackets
        self
    end

    def add_cases(keys, values)
        ### a.zip(b) -> [ [ a[0], b[0] ], [ a[n], b[n] ] ]
        keys.zip(values).each do |i| 
            indent
            @output += "case #{i[0]} = \"#{i[1]}\""
            newline 
        end
        newline
        self
    end

    def start_computed_property(name, type)
        indent
        @output += "var #{name}: #{type}"
        open_brackets
        self
    end

    def return_localized_string
        indent
        @output += "return NSLocalizedString(rawValue, comment: \"\")"
        newline
        self
    end
end
