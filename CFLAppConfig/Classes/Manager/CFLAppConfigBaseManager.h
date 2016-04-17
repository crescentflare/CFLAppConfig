//
//  CFLAppConfigBaseManager.h
//  CFLAppConfig Pod
//
//  Library manager: base manager for app customization
//  Derive your custom config manager from this class for integration
//

//Import
@import Foundation;
#import "CFLAppConfigBaseModel.h"

//Interface definition
@interface CFLAppConfigBaseManager : NSObject

//Obtain a new instance of the configuration model
//Override in your derived manager (check the example for details)
- (CFLAppConfigBaseModel *)obtainBaseModelInstance;

//Used by the derived manager to return the selected configuration instance
//Will usually be typecasted to the specific model class for the app
- (CFLAppConfigBaseModel *)currentConfigInstance;

//Internal method to apply a new configuration selection to the model
- (void)applyConfigToModel:(NSDictionary *)config withName:(NSString *)name;

@end
