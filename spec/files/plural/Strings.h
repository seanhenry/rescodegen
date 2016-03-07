@import Foundation;

typedef NS_ENUM(NSInteger, SingularString) {
    SingularString_first_key,
    SingularString_key_with_format,
    SingularString_key_without_description,
};

typedef NS_ENUM(NSInteger, PluralString) {
    PluralString_downloads_remaining,
    PluralString_souls_days,
};

NSString* LocalizedSingularString(SingularString singularString);
NSString* LocalizedPluralString(PluralString pluralString, ...);
