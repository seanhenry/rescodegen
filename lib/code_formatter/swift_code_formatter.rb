require_relative 'code_formatter'

class SwiftCodeFormatter < CodeFormatter

	def format_string(string)
		string.sub(/^[A-Z]+/) { |s| downcase_string_unless_acronym(s) }
		.gsub(/_[A-Z]+/) { |s| downcase_string_unless_acronym(s) }
	end
end
