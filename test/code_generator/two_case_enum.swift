import Foundation

struct Strings {

    enum Singular: String {
        case key1 = "value1"
        case key2 = "value2"

        var localizedString: String {
            return NSLocalizedString(rawValue, comment: "")
        }
    }
}
