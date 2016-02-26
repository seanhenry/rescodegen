@import Foundation;

typedef NS_ENUM(NSInteger, StringSingular) {
	StringSingularKey1,
	StringSingularKey2,
};

NSString* NSStringFromStringSingular(StringSingular stringSingular) {
    switch (stringSingular) {
    	case StringSingularKey1:
    		return @"value1";
    	case StringSingularKey2:
    		return @"value2";
        default:
            return @"";
    }
}
