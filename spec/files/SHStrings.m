
#import "SHStrings.h"

NSString* SHLocalizedSingularString(SHSingularString singularString) {
    switch (singularString) {
        case SHSingularString_first_key:
            return NSLocalizedString(@"First key", @"");
        case SHSingularString_key_with_format:
            return NSLocalizedString(@"Key with format %ld", @"");
        case SHSingularString_key_without_description:
            return NSLocalizedString(@"Key without description", @"");
        default:
            return @"";
    }
}
