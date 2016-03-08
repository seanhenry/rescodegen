
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

NSString* NSStringFromPluralString(PluralString pluralString) {
    switch (pluralString) {
        case PluralString_downloads_remaining:
            return NSLocalizedString(@"%lu downloads remaining", @"");
        case PluralString_souls_days:
            return NSLocalizedString(@"%lu souls, %lu days", @"");
        default:
            return @"";
    }
}

NSString* LocalizedPluralString(PluralString pluralString, ...) {
    va_list args;
    va_start(args, pluralString);
    NSString *string = [[NSString alloc] initWithFormat:NSStringFromPluralString(pluralString) locale:[NSLocale currentLocale] arguments:args];
    va_end(args);
    return string;
}
