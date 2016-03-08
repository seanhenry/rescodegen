
#import "SHStrings.h"

NSString* NSStringFromPluralString(SHPluralString pluralString) {
    switch (pluralString) {
        case SHPluralString_key1:
            return NSLocalizedString(@"value1", @"");
        case SHPluralString_key2:
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
