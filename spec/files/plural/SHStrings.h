@import Foundation;

typedef NS_ENUM(NSInteger, SHSingularString) {
    SHSingularString_first_key,
    SHSingularString_key_with_format,
    SHSingularString_key_without_description,
};

typedef NS_ENUM(NSInteger, SHPluralString) {
    SHPluralString_downloads_remaining,
    SHPluralString_souls_days,
}

NSString* SHLocalizedSingularString(SHSingularString singularString);
NSString* SHLocalizedPluralString(SHPluralString pluralString, ...);
