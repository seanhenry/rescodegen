# rescodegen
A command line tool for creating Swift and Objective-C code from localizable strings.
## Installation
`$ sudo gem install rescodegen`

## Usage
### Generate Code
`$ rescodegen -l swift -o output_folder Localizable.strings`
### Options

|Option|Value|Description   |
|---|---|---|
|-l|swift\|objc|The language of the generated code|
|-o|directory|Where to generate the files|
## Example
### Localizable.strings  

```
/* The Ok button label displayed when an error occurs on the home screen. */
"HomeScreen.Alert.OkButtonLabel" = "Ok";

/* The error message displayed by an alert when content could not be loaded. */
"HomeScreen.Alert.LoadErrorMessage" = "There was an error loading your content.";
```
### Generate Code

```
$ rescodegen -l swift -o . Localizable.strings
$ rescodegen -l objc -o . Localizable.strings
```
### Swift
Access localised strings using the `localizedString` property.
`Strings.Singular.homeScreen_alert_loadErrorMessage.localizedString`
### Objective-C
Access localised strings using the `LocalizedSingularString` function.
`LocalizedSingularString(SingularStringHomeScreen_alert_loadErrorMessage);`
