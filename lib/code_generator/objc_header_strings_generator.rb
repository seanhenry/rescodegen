require './lib/code_generator/strings_generator'

class ObjcHeaderStringsGenerator < StringsGenerator

	def generate(keys, values)
		super(keys, values)
		import_module("Foundation")
		.start_enum("StringSingular", "NSInteger")
		.finish_enum
		.start_c_method("NSString*", "NSStringFromStringSingular", "StringSingular", "stringSingular")
			.start_switch("stringSingular")
				.start_default_case
					.return_value("@\"\"")
				.finish_default_case
			.close_brackets
		.close_brackets
		.newline
			# .add_cases(keys, values)
		@output
	end

protected

	def import_module(name)
		@output += "@import #{name};"
		newline.newline
		self
	end

	# def start_struct(name)
	# 	@output += "struct #{name} "
	# 	open_brackets
	# 	newline
	# 	self
	# end

	def start_enum(name, type)
		indent
		@output += "typedef NS_ENUM(#{type}, #{name})"
		open_brackets
		self
	end

	# def add_cases(keys, values)
	# 	### a.zip(b) -> [ [ a[0], b[0] ], [ a[n], b[n] ] ]
	# 	keys.zip(values).each do |i| 
	# 		indent
	# 		@output += "case #{i[0]} = \"#{i[1]}\""
	# 		newline 
	# 	end
	# 	newline
	# 	self
	# end

	def start_c_method(return_type, name, parameter_type, parameter_name)
		newline
		@output += "#{return_type} #{name}(#{parameter_type} #{parameter_name})"
		open_brackets
		self
	end

	def start_switch(value)
		indent
		@output += "switch (#{value})"
		open_brackets
		self
	end

	def start_default_case
		indent
		@output += "default:"
		increment_indent_level
		newline
		self
	end

	def finish_default_case
		decrement_indent_level
		self
	end

	def return_value(value)
		indent
		@output += "return #{value};"
		newline
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
