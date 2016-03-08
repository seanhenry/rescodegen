require_relative 'strings_generator'

module Rescodegen
    class ObjcMainStringsGenerator < StringsGenerator

        def initialize(prefix)
            @prefix = prefix
        end

        def generate(singular_keys, singular_values, plural_keys, plural_values)
            super(singular_keys, singular_values, plural_keys, plural_values)
            newline
            .import_header(prefix("Strings.h"))
            .newline
            .add_singular_methods(singular_keys, singular_values)
            .add_plural_methods(plural_keys, plural_values)
            @output
        end

        protected

            def add_singular_methods(keys, values)
                return self if keys.size == 0
                enum_name = prefix "SingularString"
                start_c_method("NSString*", prefix("LocalizedSingularString"), "#{enum_name} singularString")
                    .start_switch("singularString")
                        .add_cases(keys.map { |k| enum_name + "_" + k }, values)
                    .close_brackets
                .close_brackets
            end

            def add_plural_methods(keys, values)
                return self if keys.size == 0
                enum_name = prefix "PluralString"
                start_c_method("NSString*", "NSStringFromPluralString", "#{enum_name} pluralString")
                    .start_switch("pluralString")
                        .add_cases(keys.map { |k| enum_name + "_" + k }, values)
                    .close_brackets
                .close_brackets
                .start_c_method("NSString*", prefix("LocalizedPluralString"), "#{enum_name} pluralString, ...")
                    .return_localized_plural_string
                .close_brackets
            end

            def import_header(name)
                @output += "#import \"#{name}\""
                self
            end

            def start_c_method(return_type, name, parameter_list)
                newline
                @output += "#{return_type} #{name}(#{parameter_list})"
                open_brackets
            end

            def start_switch(value)
                indent
                @output += "switch (#{value})"
                open_brackets
            end

            def add_cases(keys, values)
                i = 0
                until i == keys.size
                    start_case(keys[i])
                        .return_value(localized_string(values[i]))
                    .finish_case
                    i += 1
                end
                add_default_case
            end

            def add_default_case
                start_default_case
                    .return_value("@\"\"")
                .finish_case
            end

            def start_case(key)
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
            end

            def finish_case
                decrement_indent_level
            end

            def return_value(value)
                indent
                @output += "return #{value};"
                newline
            end

            def localized_string(value) 
                return "NSLocalizedString(@\"#{value}\", @\"\")"
            end

            def return_localized_plural_string
                add_line("va_list args")
                .add_line("va_start(args, pluralString)")
                .add_line("NSString *string = [[NSString alloc] initWithFormat:NSStringFromPluralString(pluralString) locale:[NSLocale currentLocale] arguments:args]")
                .add_line("va_end(args)")
                .add_line("return string")
            end

            def add_line(line)
                indent
                @output += "#{line};"
                newline
            end
    end
end
