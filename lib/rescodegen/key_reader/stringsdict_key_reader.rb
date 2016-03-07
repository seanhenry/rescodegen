require 'plist'

module Rescodegen

    class StringsdictKeyReader

        def read_keys_from_lines(lines)
            plist = Plist::parse_xml lines.join("\n")
            raise "Invalid plist file" if plist.nil?
            plist.map { |k, _| k }
        end
    end
end
