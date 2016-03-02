@import Foundation;

typedef NS_ENUM(NSInteger, SHSingularString) {
    SHSingularStringKey1,
    SHSingularStringKey2,
};

NSString* SHLocalizedSingularString(SHSingularString singularString);
