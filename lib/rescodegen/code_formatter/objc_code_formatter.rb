require_relative 'code_formatter'

module Rescodegen
    class ObjcCodeFormatter < CodeFormatter

        def format_string(string)
            string.sub(/^[a-z]/, &:upcase)
            .gsub(/_[A-Z]+/) { |s| downcase_string_unless_acronym(s) }
        end
    end
end
