
#import "Strings.h"

NSString* LocalizedSingularString(SingularString singularString) {
    switch (singularString) {
        case SingularString_first_key:
            return NSLocalizedString(@"First key", @"");
        case SingularString_key_with_format:
            return NSLocalizedString(@"Key with format %ld", @"");
        case SingularString_key_without_description:
            return NSLocalizedString(@"Key without description", @"");
        default:
            return @"";
    }
}
