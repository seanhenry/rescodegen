import Foundation

struct Strings {

    enum Singular: String {
        case first_key = "First key"
        case key_with_format = "Key with format %ld"
        case key_without_description = "Key without description"

        var localizedString: String {
            return NSLocalizedString(rawValue, comment: "")
        }
    }

    enum Plural: String {
        case downloads_remaining = "%lu downloads remaining"
        case souls_days = "%lu souls, %lu days"

        func localizedString(args: CVarArgType...) -> String {
            let localized = NSLocalizedString(rawValue, comment: "")
            return String(format: localized, locale: NSLocale.currentLocale(), arguments: args)
        }
    }
}
