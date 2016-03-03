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
}
