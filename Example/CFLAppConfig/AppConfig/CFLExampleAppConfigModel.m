//
//  CFLExampleAppConfigModel.m
//  CFLAppConfig Example
//

//Import
#import "CFLExampleAppConfigModel.h"

//Internal interface definition
@interface CFLExampleAppConfigModel ()
@end

//Interface implementation
@implementation CFLExampleAppConfigModel

+ (NSDictionary *)modelStructure
{
    return @{
             @"categories": @[
                     @{ @"categoryName": @"API related", @"fields": @[
                                @{ @"fieldName": @"apiUrl", @"defaultValue": @"https://production.example.com/" },
                                @{ @"fieldName": @"networkTimeoutSec", @"defaultValue": @20 },
                                @{ @"fieldName": @"acceptAllSSL", @"defaultValue": @NO }
                                ]}
                     ],
             @"fields": @[
                     @{ @"fieldName": @"name", @"defaultValue": @"Production" },
                     @{ @"fieldName": @"runType", @"defaultValue": @(CFLExampleAppConfigRunTypeNormally), @"customSerializer": [CFLExampleAppConfigRunTypeSerializer new] }
                     ]
             };
}

@end
