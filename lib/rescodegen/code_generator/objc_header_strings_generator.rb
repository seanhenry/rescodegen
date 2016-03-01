require_relative 'strings_generator'

module Rescodegen
    class ObjcHeaderStringsGenerator < StringsGenerator

        def generate(keys, values)
            super(keys, values)
            import_module("Foundation")
            .start_enum("SingularString", "NSInteger")
                .add_cases("SingularString", keys)
            .finish_enum
            .add_c_method("NSString*", "LocalizedSingularString", "SingularString", "singularString")
            .newline
            @output
        end

    protected

        def import_module(name)
            @output += "@import #{name};"
            newline.newline
            self
        end

        def start_enum(name, type)
            indent
            @output += "typedef NS_ENUM(#{type}, #{name})"
            open_brackets
            self
        end

        def add_c_method(return_type, name, parameter_type, parameter_name)
            newline
            @output += "#{return_type} #{name}(#{parameter_type} #{parameter_name});"
            self
        end

        def add_cases(enum_name, keys)
            keys.each do |key|
                indent
                @output += "#{enum_name}#{key},"
                newline
            end
            self
        end

        def finish_enum
            decrement_indent_level
            indent
            @output += "};"
            newline
            self
        end
    end
end
