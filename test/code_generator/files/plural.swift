import Foundation

struct Strings {

    enum Plural: String {
        case key1 = "value1"
        case key2 = "value2"

        func localizedString(args: CVarArgType...) -> String {
            let localized = NSLocalizedString(rawValue, comment: "")
            return String(format: localized, locale: NSLocale.currentLocale(), arguments: args)
        }
    }
}
