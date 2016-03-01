
module Rescodegen
    class StringsKeyGenerator

        def self.create_from_file(input_file)
            lines = File.open(input_file, "rb:UTF-16BE")
            StringsKeyGenerator.new lines
        end

        def initialize(lines)
            @keys = lines.map { |l| l.encode("UTF-8", :invalid=>:replace, :replace=>"?").encode('UTF-8') }
            .reject { |l| l.strip == "" }
            .select { |l| l[0] == "\"" }
            .map do |line|
                line.gsub(/\n$/, "")
                .gsub(/(")(.*)(" = ".*)/, "\\2") # extracts key from "key" = "description"; format
            end
        end

        def keys
            @keys
        end

        def code_safe_keys
            @keys.map do |key|
                key.gsub(/%\.[0-9]f|%[a-zA-Z@]+/, "_") # replace %d, %ld, %.2f etc
                .gsub(/[^a-zA-Z0-9]/, "_") # replace unsupported characters 
                .gsub(/(\s|_)+/, "_") # replaces 1 or more occurance of whitespace and/or '_' with single '_'
                .gsub(/^_|_$/, "") # remove _ from beginning and end 
                .gsub(/(^[0-9])/, "_\\1") # add underscore at beginning if starts with number
            end
        end
    end
end
