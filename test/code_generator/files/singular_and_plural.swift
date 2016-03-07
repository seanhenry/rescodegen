import Foundation

struct Strings {

    enum Singular: String {
        case key1 = "value1"
        case key2 = "value2"

        var localizedString: String {
            return NSLocalizedString(rawValue, comment: "")
        }
    }

    enum Plural: String {
        case key3 = "value3"
        case key4 = "value4"

        func localizedString(args: CVarArgType...) -> String {
            let localized = NSLocalizedString(rawValue, comment: "")
            return String(format: localized, locale: NSLocale.currentLocale(), arguments: args)
        }
    }
}
