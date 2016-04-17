//
//  CFLExampleAppConfigManager.m
//  CFLAppConfig Example
//

//Import
#import "CFLExampleAppConfigManager.h"

//Internal interface definition
@interface CFLExampleAppConfigManager ()
@end

//Interface implementation
@implementation CFLExampleAppConfigManager

+ (CFLExampleAppConfigManager *)sharedManager
{
    static CFLExampleAppConfigManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^                  {
        _sharedManager = [[CFLExampleAppConfigManager alloc] init];
    });
    return _sharedManager;
}

- (CFLAppConfigBaseModel *)obtainBaseModelInstance
{
    return [CFLExampleAppConfigModel new];
}

+ (CFLExampleAppConfigModel *)currentConfig
{
    return (CFLExampleAppConfigModel *)[[CFLExampleAppConfigManager sharedManager] currentConfigInstance];
}

@end
