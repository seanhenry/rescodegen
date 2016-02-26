import Foundation

struct Strings {

    enum Singular: String {

        var localizedString: String {
            return NSLocalizedString(rawValue, comment: "")
        }
    }
}
