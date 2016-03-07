@import Foundation;

typedef NS_ENUM(NSInteger, SHSingularString) {
    SHSingularString_key1,
    SHSingularString_key2,
};

NSString* SHLocalizedSingularString(SHSingularString singularString);
