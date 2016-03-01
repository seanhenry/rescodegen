
class CodeFormatter

protected
	def downcase_string_unless_acronym(string)
		string.downcase! unless string.tr("_", "").size > 1
		string
	end
end
