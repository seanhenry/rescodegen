
module Rescodegen
    class CodeFormatter

    def format_string(string)
            string.sub(/^[A-Z]+/) { |s| downcase_string_unless_acronym(s) }
            .gsub(/_[A-Z]+/) { |s| downcase_string_unless_acronym(s) }
    end

    private
        def downcase_string_unless_acronym(string)
            string.downcase! unless string.tr("_", "").size > 1
            string
        end
    end
end
