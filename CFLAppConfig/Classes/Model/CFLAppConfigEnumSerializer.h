//
//  CFLAppConfigEnumSerializer.h
//  CFLAppConfig Pod
//
//  Library model: helper for creating serialized string enums
//  When using enums, derive them from this class and implement the states and default value methods
//

@import Foundation;

@interface CFLAppConfigEnumSerializer : NSObject

+ (NSInteger)defaultValue;
+ (NSDictionary *)states;
+ (NSString *)fromEnumValue:(NSInteger)enumValue;
+ (NSInteger)fromStringValue:(NSString *)stringValue;

@end
