
#import "Strings.h"

NSString* LocalizedSingularString(SingularString singularString) {
    switch (singularString) {
        case SingularStringKey1:
            return NSLocalizedString(@"value1", @"");
        case SingularStringKey2:
            return NSLocalizedString(@"value2", @"");
        default:
            return @"";
    }
}
