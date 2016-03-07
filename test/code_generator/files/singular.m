
#import "SHStrings.h"

NSString* SHLocalizedSingularString(SHSingularString singularString) {
    switch (singularString) {
        case SHSingularString_key1:
            return NSLocalizedString(@"value1", @"");
        case SHSingularString_key2:
            return NSLocalizedString(@"value2", @"");
        default:
            return @"";
    }
}
