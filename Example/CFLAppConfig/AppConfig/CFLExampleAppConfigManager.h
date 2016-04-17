//
//  CFLExampleAppConfigManager.h
//  CFLAppConfig Example
//
//  App config: manager class to facilitate app config selection and model definition
//

//Imports
@import Foundation;
@import CFLAppConfig;
#import "CFLExampleAppConfigModel.h"

//Interface definition
@interface CFLExampleAppConfigManager : CFLAppConfigBaseManager

+ (CFLExampleAppConfigManager *)sharedManager;
- (CFLAppConfigBaseModel *)obtainBaseModelInstance;
+ (CFLExampleAppConfigModel *)currentConfig;

@end
