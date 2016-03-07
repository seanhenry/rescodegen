@import Foundation;

typedef NS_ENUM(NSInteger, SHPluralString) {
    SHPluralString_key1,
    SHPluralString_key2,
};

NSString* SHLocalizedPluralString(SHPluralString pluralString, ...);
