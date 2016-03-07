require_relative 'strings_generator'

module Rescodegen
    class ObjcHeaderStringsGenerator < StringsGenerator

        def initialize(prefix)
            @prefix = prefix
        end

        def generate(singular_keys, singular_values, plural_keys, plural_values)
            super(singular_keys, singular_values, plural_keys, plural_values)
            import_module("Foundation")
            .singular_enum(singular_keys, singular_values)
            .plural_enum(plural_keys, plural_values)
            add_c_method("NSString*", prefix("LocalizedSingularString"), "#{singular_enum_name} singularString") if singular_keys.size != 0
            add_c_method("NSString*", prefix("LocalizedPluralString"), "#{plural_enum_name} pluralString, ...") if plural_keys.size != 0
            newline
            @output
        end

    protected

        def singular_enum(keys, values)
            return self if keys.size == 0
            newline
            .start_enum(singular_enum_name, "NSInteger")
                .add_cases(singular_enum_name, keys)
            .finish_enum
        end

        def plural_enum(keys, values)
            return self if keys.size == 0
            newline
            .start_enum(plural_enum_name, "NSInteger")
                .add_cases(plural_enum_name, keys)
            .finish_enum
        end

        def import_module(name)
            @output += "@import #{name};"
            newline
        end

        def start_enum(name, type)
            indent
            @output += "typedef NS_ENUM(#{type}, #{name})"
            open_brackets
        end

        def add_c_method(return_type, name, parameter_list)
            newline
            @output += "#{return_type} #{name}(#{parameter_list});"
            self
        end

        def add_cases(enum_name, keys)
            keys.each do |key|
                indent
                @output += "#{enum_name}_#{key},"
                newline
            end
            self
        end

        def finish_enum
            decrement_indent_level
            indent
            @output += "};"
            newline
        end

        def singular_enum_name 
            prefix "SingularString"
        end

        def plural_enum_name 
            prefix "PluralString"
        end
    end
end
