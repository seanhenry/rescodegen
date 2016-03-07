
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

NSString* SHLocalizedPluralString(SHPluralString pluralString, ...) {
    va_list args;
    va_start(args, pluralString);
    NSString *string = [[NSString alloc] initWithFormat:NSStringFromPluralString(pluralString) locale:[NSLocale currentLocale] arguments:args];
    va_end(args);
    return string;
}

NSString* NSStringFromPluralString(SHPluralString pluralString) {
    switch (pluralString) {
        case SHPluralString_downloads_remaining:
            return NSLocalizedString(@"%lu downloads remaining", @"");
        case SHPluralString_souls_days:
            return NSLocalizedString(@"%lu souls, %lu days", @"");
        default:
            return @"";
    }
}
