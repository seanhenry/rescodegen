class CodeGeneratorTestHelper

    def file_is_generated_by_keys_values(generator, file_name, keys, values)
        generated_code = generator.generate(keys, values).split("\n")
        expected_file = file_lines file_name
        if expected_file.size != generated_code.size 
            handle_unequal_line_counts(expected_file, generated_code)
            return false
        end
        i = 0
        while i < expected_file.count do
            if expected_file[i] != generated_code[i]
                handle_unequal_lines_at(expected_file, generated_code, i)
                return false
            end
            i += 1
        end
        true
    end

private
    def file_lines(file_name)
        file_path = Dir.pwd + "/tests/code_generator/" + file_name
        File.readlines(file_path).map do |line|
            line.gsub(/\n/, "")
        end
    end

    def handle_unequal_line_counts(expected_file, generated_code)
        puts "Expected line count #{expected_file.size}, got #{generated_code.size}"
        puts "Generated lines:\n" + print_lines(generated_code)
        puts "Expected lines: \n" + print_lines(expected_file)
    end

    def handle_unequal_lines_at(expected_file, generated_code, index)
        puts "Expected line #{expected_file[index]} got: #{generated_code[index]}"
        puts "Line number: #{index + 1}"
        puts "Generated lines:\n" + print_lines(generated_code)
        puts "Expected lines: \n" + print_lines(expected_file)
    end

    def print_lines lines 
        lines.join("\n")
    end
end
