//
//  CFLAppConfigBaseManager.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigBaseManager.h"

//Internal interface definition
@interface CFLAppConfigBaseManager ()

@property (nonatomic, strong) CFLAppConfigBaseModel *currentConfig;

@end

//Interface implementation
@implementation CFLAppConfigBaseManager

- (CFLAppConfigBaseModel *)obtainBaseModelInstance
{
    return [CFLAppConfigBaseModel new];
}

- (CFLAppConfigBaseModel *)currentConfigInstance
{
    if (!self.currentConfig)
    {
        self.currentConfig = [self obtainBaseModelInstance];
    }
    return self.currentConfig;
}

- (void)applyConfigToModel:(NSDictionary *)config withName:(NSString *)name
{
    self.currentConfig = [self obtainBaseModelInstance];
    if (config)
    {
        [self.currentConfig applyOverrides:config withName:name];
    }
}

@end