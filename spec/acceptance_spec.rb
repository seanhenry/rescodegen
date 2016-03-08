$output_file = "spec_output"
$localizable_strings_file = "spec/files/Localizable.strings"
$localizable_strings_file2 = "spec/files/Localizable2.strings"
$localizable_stringsdict_file = "spec/files/plural/Localizable.stringsdict"
$swift_file = "spec/files/Strings.swift"
$objc_header_file = "spec/files/Strings.h"
$objc_main_file = "spec/files/Strings.m"
$objc_prefix_header_file = "spec/files/SHStrings.h"
$objc_prefix_main_file = "spec/files/SHStrings.m"
$swift_plural_file = "spec/files/plural/Strings.swift"
$objc_plural_header_file = "spec/files/plural/Strings.h"
$objc_plural_main_file = "spec/files/plural/Strings.m"
$objc_plural_prefix_header_file = "spec/files/plural/SHStrings.h"
$objc_plural_prefix_main_file = "spec/files/plural/SHStrings.m"
$multi_file_swift_file = "spec/files/MultiFileStrings.swift"

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

def run_with_invalid_file
    run "invalid.xml"
end

def run_with_empty_file
    run "empty.strings"
end

def run_with_strings_file
    run "-o #{$output_file} -i #{$localizable_strings_file}"
end

def run_with_objc_and_strings_file
    run "-o #{$output_file} -l objc -i #{$localizable_strings_file}"
end

def run_with_prefix_and_strings_file
    run "-o #{$output_file} -l objc -p SH -i #{$localizable_strings_file}"
end

def run_with_strings_and_stringsdict_files
    run "-o #{$output_file} -i #{$localizable_strings_file} -i #{$localizable_stringsdict_file}"
end

def run_with_objc_strings_and_stringsdict_files
    run "-o #{$output_file} -l objc -i #{$localizable_strings_file} -i #{$localizable_stringsdict_file}"
end

def run_with_objc_prefix_strings_and_stringsdict_file
    run "-o #{$output_file} -l objc -p SH -i #{$localizable_strings_file} -i #{$localizable_stringsdict_file}"
end

def run_with_multiple_files
    run "-o #{$output_file} -i #{$localizable_strings_file} -i #{$localizable_strings_file2}"
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

    context "when providing invalid format" do
        it "should fail" do
            expect(run_with_invalid_file).to be false
        end
    end

    context "when providing files with no keys" do
        it "should fail" do
            expect(run_with_empty_file).to be false
        end
    end

    context "when providing strings file" do
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

    context "when providing stringsdict and strings files" do
        it "should generate a Swift file" do
            expect(run_with_strings_and_stringsdict_files).to be true
            expect(output_file_to_string("Strings.swift")).to eq file_to_string($swift_plural_file)
        end
        context "and requesting objc" do
            it "should generate objc files" do
                expect(run_with_objc_strings_and_stringsdict_files).to be true
                expect(output_file_to_string("Strings.h")).to eq file_to_string($objc_plural_header_file)
                expect(output_file_to_string("Strings.m")).to eq file_to_string($objc_plural_main_file)
            end
            context "and requesting a prefix" do
                it "should generate prefixed files" do
                    expect(run_with_objc_prefix_strings_and_stringsdict_file).to be true
                    expect(output_file_to_string("SHStrings.h")).to eq file_to_string($objc_plural_prefix_header_file)
                    expect(output_file_to_string("SHStrings.m")).to eq file_to_string($objc_plural_prefix_main_file)
                end
            end
        end
    end

    context "when providing multiple files" do
        it "should generate keys from both files" do
            expect(run_with_multiple_files).to be true
            expect(output_file_to_string("Strings.swift")).to eq file_to_string($multi_file_swift_file)
        end
    end
end
