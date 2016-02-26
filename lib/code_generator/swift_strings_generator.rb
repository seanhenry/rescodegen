
class SwiftStringsGenerator

	def generate(keys, values)
		raise "Expects keys and values of equal sizes" if keys.size != values.size
		@output = ""
		@tab_level = 0
		import_header("Foundation")
		start_struct("Strings")
			.start_enum("Singular", "String")
				.add_cases(keys, values)
				.start_computed_property("localizedString", "String")
					.return_localized_string
				.close_brackets
			.close_brackets
		.close_brackets
		@output
	end

	def newline
		@output += "\n"
		self
	end

	def import_header(name)
		@output += "import #{name}"
		newline.newline
		self
	end

	def start_struct(name)
		@output += "struct #{name} "
		open_brackets
		newline
		self
	end

	def start_enum(name, type)
		indent
		@output += "enum #{name}: #{type} "
		open_brackets
		self
	end

	def add_cases(keys, values)
		### a.zip(b) -> [ [ a[0], b[0] ], [ a[n], b[n] ] ]
		keys.zip(values).each do |i| 
			indent
			@output += "case #{i[0]} = \"#{i[1]}\""
			newline 
		end
		newline
		self
	end

	def start_computed_property(name, type)
		indent
		@output += "var #{name}: #{type} "
		open_brackets
		self
	end

	def return_localized_string
		indent
		@output += "return NSLocalizedString(rawValue, comment: \"\")"
		newline
		self
	end

	def open_brackets
		@output += "{"
		newline
		increment_indent_level
		self
	end

	def close_brackets
		decrement_indent_level
		indent
		@output += "}"
		newline
		self
	end

	def increment_indent_level
		@tab_level += 1
		self
	end

	def decrement_indent_level
		@tab_level -= 1
		self
	end

	def indent
		@output += (1..@tab_level).reduce("") { |a, b| a + tab }
		self
	end

	def tab
		"    "
	end
end
