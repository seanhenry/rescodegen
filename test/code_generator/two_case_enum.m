
#import "Strings.h"

NSString* LocalizedSingularString(SingularString singularString) {
    switch (singularString) {
        case SingularStringKey1:
            return @"value1";
        case SingularStringKey2:
            return @"value2";
        default:
            return @"";
    }
}
