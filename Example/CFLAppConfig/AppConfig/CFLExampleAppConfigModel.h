//
//  CFLExampleAppConfigModel.h
//  CFLAppConfig Example
//
//  App config: application configuration
//  A convenience model used by the build environment selector and has strict typing
//  Important when using model structure to define default values: always reflect a production situation
//

//Imports
@import Foundation;
@import CFLAppConfig;
#import "CFLExampleAppConfigRunType.h"

//Interface definition
@interface CFLExampleAppConfigModel : CFLAppConfigBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *apiUrl;
@property (nonatomic, assign) NSInteger networkTimeoutSec;
@property (nonatomic, assign) BOOL acceptAllSSL;
@property (nonatomic, assign) CFLExampleAppConfigRunType runType;

@end
