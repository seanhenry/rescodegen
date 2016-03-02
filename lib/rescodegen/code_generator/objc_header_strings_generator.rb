require_relative 'strings_generator'

module Rescodegen
    class ObjcHeaderStringsGenerator < StringsGenerator

        def initialize(prefix)
            @prefix = prefix
        end

        def generate(keys, values)
            super(keys, values)
            enum_name = prefix "SingularString"
            import_module("Foundation")
            .start_enum(enum_name, "NSInteger")
                .add_cases(enum_name, keys)
            .finish_enum
            .add_c_method("NSString*", prefix("LocalizedSingularString"), enum_name, "singularString")
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
            self
        end
    end
end
