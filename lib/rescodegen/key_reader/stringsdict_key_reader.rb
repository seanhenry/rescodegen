require 'plist'

class StringsdictKeyReader

    def read_keys_from_lines(lines)
        plist = Plist::parse_xml lines.join("\n")
        raise "Invalid plist file" if plist.nil?
        plist.map { |k, v| k }
    end
end
