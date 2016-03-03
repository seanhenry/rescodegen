@import Foundation;

typedef NS_ENUM(NSInteger, SHSingularString) {
    SHSingularString_first_key,
    SHSingularString_key_with_format,
    SHSingularString_key_without_description,
};

NSString* SHLocalizedSingularString(SHSingularString singularString);
