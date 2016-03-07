@import Foundation;

typedef NS_ENUM(NSInteger, SHSingularString) {
    SHSingularString_key1,
    SHSingularString_key2,
};

typedef NS_ENUM(NSInteger, SHPluralString) {
    SHPluralString_key3,
    SHPluralString_key4,
};

NSString* SHLocalizedSingularString(SHSingularString singularString);
NSString* SHLocalizedPluralString(SHPluralString pluralString, ...);
