require_relative 'strings_generator'

module Rescodegen
    class ObjcMainStringsGenerator < StringsGenerator

        def generate(keys, values)
            super(keys, values)
            newline
            .import_header("Strings.h")
            .newline
            .start_c_method("NSString*", "LocalizedSingularString", "SingularString", "singularString")
                .start_switch("singularString")
                    .add_cases(keys.map { |k| "SingularString" + k }, values)
                .close_brackets
            .close_brackets
            .newline
            @output
        end

        def import_header(name)
            @output += "#import \"#{name}\""
            self
        end

        def start_c_method(return_type, name, parameter_type, parameter_name)
            newline
            @output += "#{return_type} #{name}(#{parameter_type} #{parameter_name})"
            open_brackets
            self
        end

        def start_switch(value)
            indent
            @output += "switch (#{value})"
            open_brackets
            self
        end

        def add_cases(keys, values)
            i = 0
            until i == keys.size
                start_case(keys[i], values[i])
                    .return_value(localized_string(values[i]))
                .finish_case
                i += 1
            end
            add_default_case
            self
        end

        def add_default_case
            start_default_case
                .return_value("@\"\"")
            .finish_case
        end

        def start_case(key, value)
            indent
            @output += "case #{key}:"
            newline
            increment_indent_level
        end

        def start_default_case
            indent
            @output += "default:"
            newline
            increment_indent_level
            self
        end

        def finish_case
            decrement_indent_level
            self
        end

        def return_value(value)
            indent
            @output += "return #{value};"
            newline
            self
        end

        def localized_string(value) 
            return "NSLocalizedString(@\"#{value}\", @\"\")"
        end
    end
end
