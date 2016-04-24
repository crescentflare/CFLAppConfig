//
//  CFLAppConfigEditTableValue.h
//  CFLAppConfig Pod
//
//  Library table value: edit configuration
//  A table model with different table cell types for the edit config viewcontroller
//  Used internally
//

//Import
@import Foundation;

//Value type enum
typedef enum
{
    CFLAppConfigEditTableValueTypeUnknown = 0,
    CFLAppConfigEditTableValueTypeLoading,
    CFLAppConfigEditTableValueTypeAction,
    CFLAppConfigEditTableValueTypeEditText,
    CFLAppConfigEditTableValueTypeSlider,
    CFLAppConfigEditTableValueTypeSelection,
    CFLAppConfigEditTableValueTypeSection
}CFLAppConfigEditTableValueType;

//Action type enum
typedef enum
{
    CFLAppConfigEditTableValueActionSave = 0,
    CFLAppConfigEditTableValueActionCancel
}CFLAppConfigEditTableValueAction;

//Interface definition
@interface CFLAppConfigEditTableValue : NSObject

@property (nonatomic, strong, readonly) NSString *configSetting;
@property (nonatomic, strong, readonly) NSString *labelString;
@property (nonatomic, assign, readonly) BOOL booleanValue;
@property (nonatomic, assign, readonly) BOOL limitUsage;
@property (nonatomic, assign, readonly) CFLAppConfigEditTableValueType type;
@property (nonatomic, assign, readonly) CFLAppConfigEditTableValueAction action;

+ (CFLAppConfigEditTableValue *)valueForLoading:(NSString *)loadingText;
+ (CFLAppConfigEditTableValue *)valueForAction:(CFLAppConfigEditTableValueAction)action andText:(NSString *)actionLabel;
+ (CFLAppConfigEditTableValue *)valueForEditText:(NSString *)configSetting andValue:(NSString *)settingValue numberOnly:(BOOL)onlyNumbers;
+ (CFLAppConfigEditTableValue *)valueForSlider:(NSString *)configSetting andSwitchedOn:(BOOL)settingValue;
+ (CFLAppConfigEditTableValue *)valueForSelection:(NSString *)configSetting andValue:(NSString *)settingValue;
+ (CFLAppConfigEditTableValue *)valueForSection:(NSString *)sectionText;

- (NSString *)cellIdentifier;

@end
