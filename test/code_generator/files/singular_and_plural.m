
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

NSString* SHLocalizedPluralString(SHPluralString pluralString, ...) {
    va_list args;
    va_start(args, pluralString);
    NSString *string = [[NSString alloc] initWithFormat:NSStringFromPluralString(pluralString) locale:[NSLocale currentLocale] arguments:args];
    va_end(args);
    return string;
}

NSString* NSStringFromPluralString(SHPluralString pluralString) {
    switch (pluralString) {
        case SHPluralString_key3:
            return NSLocalizedString(@"value3", @"");
        case SHPluralString_key4:
            return NSLocalizedString(@"value4", @"");
        default:
            return @"";
    }
}
