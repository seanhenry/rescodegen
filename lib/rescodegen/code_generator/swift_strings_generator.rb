require_relative 'strings_generator'

module Rescodegen
    class SwiftStringsGenerator < StringsGenerator

        def generate(singular_keys, singular_values, plural_keys, plural_values)
            super(singular_keys, singular_values, plural_keys, plural_values)
            import_header("Foundation")
            start_struct("Strings")
                .add_singular_enum(singular_keys, singular_values)
                .add_plural_enum(plural_keys, plural_values)
            .close_brackets
            @output
        end

    protected

        def add_singular_enum(keys, values)
            return self if keys.size == 0
            newline
            .start_enum("Singular", "String")
                .add_cases(keys, values)
                .start_computed_property("localizedString", "String")
                    .return_localized_string
                .close_brackets
            .close_brackets
        end

        def add_plural_enum(keys, values)
            return self if keys.size == 0
            newline
            .start_enum("Plural", "String")
                .add_cases(keys, values)
                .start_function("localizedString", "args: CVarArgType...", "String")
                    .return_localized_plural_string
                .close_brackets
            close_brackets
        end

        def newline
            @output += "\n"
            self
        end

        def import_header(name)
            @output += "import #{name}"
            newline
        end

        def start_struct(name)
            newline
            @output += "struct #{name}"
            open_brackets
        end

        def start_enum(name, type)
            indent
            @output += "enum #{name}: #{type}"
            open_brackets
        end

        def add_cases(keys, values)
            ### a.zip(b) -> [ [ a[0], b[0] ], [ a[n], b[n] ] ]
            keys.zip(values).each do |i| 
                indent
                @output += "case #{i[0]} = \"#{i[1]}\""
                newline 
            end
            newline
        end

        def start_computed_property(name, type)
            indent
            @output += "var #{name}: #{type}"
            open_brackets
        end

        def return_localized_string
            indent
            @output += "return NSLocalizedString(rawValue, comment: \"\")"
            newline
        end

        def start_function(name, parameter_list, return_type)
            indent
            @output += "func #{name}(#{parameter_list}) -> #{return_type}"
            open_brackets
        end

        def return_localized_plural_string
            add_line "let localized = NSLocalizedString(rawValue, comment: \"\")"
            add_line "return String(format: localized, locale: NSLocale.currentLocale(), arguments: args)"
        end

        def add_line(line)
            indent
            @output += "#{line}"
            newline
        end
    end
end
