
#import "Strings.h"

NSString* SHLocalizedSingularString(SHSingularString singularString) {
    switch (singularString) {
        case SHSingularStringKey1:
            return NSLocalizedString(@"value1", @"");
        case SHSingularStringKey2:
            return NSLocalizedString(@"value2", @"");
        default:
            return @"";
    }
}
