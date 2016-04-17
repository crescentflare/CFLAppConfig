//
//  CFLExampleAppConfigRunType.m
//  CFLAppConfig Example
//

//Import
#import "CFLExampleAppConfigRunType.h"

//Internal interface definition
@interface CFLExampleAppConfigRunTypeSerializer ()
@end

//Interface implementation
@implementation CFLExampleAppConfigRunTypeSerializer

+ (NSInteger)defaultValue
{
    return CFLExampleAppConfigRunTypeNormally;
}

+ (NSDictionary *)states
{
    NSDictionary *states = @{
                             @"runNormally": @(CFLExampleAppConfigRunTypeNormally),
                             @"runQuickly": @(CFLExampleAppConfigRunTypeQuickly),
                             @"runStrictly": @(CFLExampleAppConfigRunTypeStrictly)
                             };
    return states;
}

@end
