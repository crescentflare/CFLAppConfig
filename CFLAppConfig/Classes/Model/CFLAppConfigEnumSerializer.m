//
//  CFLAppConfigEnumSerializer.m
//  CFLAppConfig Pod
//

#import "CFLAppConfigEnumSerializer.h"

@interface CFLAppConfigEnumSerializer()
@end

@implementation CFLAppConfigEnumSerializer

+ (NSInteger)defaultValue
{
    return 0;
}

+ (NSDictionary *)states
{
    NSDictionary *states = @{
                             @"default": @([self defaultValue])
                             };
    return states;
}

+ (NSString *)fromEnumValue:(NSInteger)enumValue
{
    NSDictionary *states = [self states];
    NSArray *foundKeys = [states allKeysForObject:[NSNumber numberWithInteger:enumValue]];
    NSString *value = nil;
    if (foundKeys)
    {
        value = [foundKeys firstObject];
    }
    if (value && ![value isEqualToString:@""])
    {
        return value;
    }
    return (NSString *)nil;
}

+ (NSInteger)fromStringValue:(NSString *)stringValue
{
    NSDictionary *states = [self states];
    return states[stringValue] ? [states[stringValue] integerValue] : [self defaultValue];
}

@end
