
module Rescodegen

    class StringsKeyReader

        def read_keys_from_lines(lines)
            lines.map(&method(:encode_line_with_utf8))
            .select(&method(:line_contains_key))
            .map(&method(:extract_key))
        end

        private
            def encode_line_with_utf8(line)
                line.encode("UTF-8", :invalid=>:replace, :replace=>"?").encode('UTF-8')
            end

            def line_contains_key(line)
                return false if line.size == 0
                line[0] == "\""
            end

            def extract_key(line) 
                line.sub(/\n$/, "")
                .sub(/(")(.*)(" = ".*)/, "\\2")
            end
    end
end
