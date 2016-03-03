$output_file = "spec_output"
$localizable_strings_file = "spec/files/Localizable.strings"
$swift_file = "spec/files/Strings.swift"
$objc_header_file = "spec/files/Strings.h"
$objc_main_file = "spec/files/Strings.m"
$objc_prefix_header_file = "spec/files/SHStrings.h"
$objc_prefix_main_file = "spec/files/SHStrings.m"

def silence_shell_output
    " &> /dev/null"
end

def run(string)
    system("bin/rescodegen " + string + silence_shell_output)
end

def run_with_language(lang)
    run "-l #{lang}"
end

def run_with_no_input_path
    run ""
end

def run_with_strings_file
    run "-o #{$output_file} #{$localizable_strings_file}"
end

def run_with_objc_and_strings_file
    run "-o #{$output_file} -l objc #{$localizable_strings_file}"
end

def run_with_prefix_and_strings_file
    run "-o #{$output_file} -l objc -p SH #{$localizable_strings_file}"
end

def file_to_string(path)
    File.read(Dir.pwd + "/" + path)
end

def test_file_to_string(path)
    file_to_string("spec" + "/" + path)
end

def output_file_to_string(path)
    file_to_string($output_file + "/" + path)
end

RSpec.describe "CLI" do

    before(:each) do
        `mkdir #{$output_file} #{silence_shell_output}`
    end

    after(:each) do
        `rm -r #{$output_file} #{silence_shell_output}`
    end

    context "when providing an invalid language" do
        it "should fail" do
            expect(run_with_language("invalid")).to be false
        end
    end

    context "when providing no input path" do
        it "should fail" do
            expect(run_with_no_input_path).to be false
        end
    end

    context "when providing correct input path" do
        it "should succeed" do 
            
        end
        it "should generate a swift file" do
            expect(run_with_strings_file).to be true
            expect(output_file_to_string("Strings.swift")).to eq file_to_string($swift_file)
        end
        context "and requesting objc" do
            it "should generate objc files" do
                expect(run_with_objc_and_strings_file).to be true
                expect(output_file_to_string("Strings.h")).to eq file_to_string($objc_header_file)
                expect(output_file_to_string("Strings.m")).to eq file_to_string($objc_main_file)
            end
            context "and requesting a prefix" do
                it "should generate prefixed files" do
                    expect(run_with_prefix_and_strings_file).to be true
                    expect(output_file_to_string("SHStrings.h")).to eq file_to_string($objc_prefix_header_file)
                    expect(output_file_to_string("SHStrings.m")).to eq file_to_string($objc_prefix_main_file)
                end
            end
        end
    end
end
