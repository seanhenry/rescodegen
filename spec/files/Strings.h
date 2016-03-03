@import Foundation;

typedef NS_ENUM(NSInteger, SingularString) {
    SingularString_first_key,
    SingularString_key_with_format,
    SingularString_key_without_description,
};

NSString* LocalizedSingularString(SingularString singularString);
