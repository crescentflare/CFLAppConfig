//
//  CFLAppConfigBaseModel.h
//  CFLAppConfig Pod
//
//  Library model: base model for strict typing
//  Derive your custom app configuration from this model for easy integration
//  Important: this moment, only flat models with primitive data types and custom enums are supported
//

//Import
@import Foundation;

//Interface definition
@interface CFLAppConfigBaseModel : NSObject

//Provides a dictionary describing the structure of the model
//Override in your derived model (check the example for details)
//---
//Useful for the following:
//- Having default values
//- Grouping model values into categories
//- Controlling sort order
+ (NSDictionary *)modelStructure;

//Helper method quickly find a field in the model structure (which can be within a category or a plain field list)
+ (NSDictionary *)modelStructureField:(NSString *)fieldName;

//Helper method to obtain a list of defined properties in the derived model, including its type
//Currently only a limited set of types are supported: boolean, integer (including enum), long and NSString
- (NSDictionary *)obtainValueTypes;

//Internal method to override the model with customized values
- (void)applyOverrides:(NSDictionary *)overrides withName:(NSString *)name;

@end
