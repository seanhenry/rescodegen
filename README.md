<a href="https://travis-ci.org/seanhenry/rescodegen"><img src="https://img.shields.io/travis/seanhenry/rescodegen.svg" /></a>
<a href="https://codeclimate.com/github/seanhenry/rescodegen/coverage"><img src="https://codeclimate.com/github/seanhenry/rescodegen/badges/coverage.svg" /></a>
<a href="https://codeclimate.com/github/seanhenry/rescodegen"><img src="https://codeclimate.com/github/seanhenry/rescodegen/badges/gpa.svg" /></a>
# rescodegen
A command line tool for creating Swift and Objective-C code from singular Localizable.strings and plural Localizable.stringsdict.
## Installation
`$ sudo gem install rescodegen`

## Usage
### Generate Code
`$ rescodegen -i Localizable.strings`
### Options

|Option|Value|Required|Default|Description   |
|---|---|---|---|---|
|`-i`|relative/path/to/Localizable.strings|✔️||The input file(s). Must be `.strings` or `.stringsdict` format. You may specify more than 1 file.|
|`-l`|swift or objc|❌|`swift`|The language of the generated code.|
|`-o`|relative/path/to/output/directory|❌|`.`|Where to save generated files.|
|`-p`|e.g. SH|❌||An optional prefix to apply to Objective-C types.|
## Example
### Localizable.strings  

```
...
/* Error message to display when uploading an image fails. */
"Uploader.ErrorAlert.Message" = "The upload failed.";
...
```
### Localizable.stringsdict  

```
...
    <key>Uploader.ProgressLabel.Text</key>
	<dict>
		<key>NSStringLocalizedFormatKey</key>
		<string>Uploading %#@images@.</string>
		<key>images</key>
		<dict>
			<key>NSStringFormatSpecTypeKey</key>
			<string>NSStringPluralRuleType</string>
			<key>NSStringFormatValueTypeKey</key>
            <string>d</string>
            <key>one</key>
            <string>one image</string>
			<key>other</key>
			<string>%d images</string>
		</dict>
	</dict>
...
```
### Generate Code

```
$ rescodegen -i Localizable.strings -i Localizable.stringsdict
$ rescodegen -i Localizable.strings -i Localizable.stringsdict -l objc
```
### Xcode
Drag the generated files into Xcode and add them to your target.
### Swift
Access localized singular strings:  
`Strings.Singular.uploader_errorAlert_message.localizedString` => "The upload failed."  
Access localized plural strings:  
`Strings.Plural.uploader_progressLabel_text.localizedString(1)` => "Uploading one image."  
### Objective-C
Access localized singular strings:  
`LocalizedSingularString(SingularString_uploader_errorAlert_message)` => "The upload failed."  
Access localized plural strings:    
`LocalizedPluralString(PluralString_uploader_progressLabel_text, 2)` => "Uploading 2 images." 
## Encoding
rescodegen currently only supports UTF-8 encoding. 
