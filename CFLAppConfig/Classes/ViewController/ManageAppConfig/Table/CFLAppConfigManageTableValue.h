//
//  CFLAppConfigManageTableValue.h
//  CFLAppConfig Pod
//
//  Library table value: managing configurations
//  A table model with different table cell types for the manage config viewcontroller
//  Used internally
//

//Import
@import Foundation;

//Value type enum
typedef enum
{
    CFLAppConfigManageTableValueTypeUnknown = 0,
    CFLAppConfigManageTableValueTypeLoading,
    CFLAppConfigManageTableValueTypeConfig,
    CFLAppConfigManageTableValueTypeInfo,
    CFLAppConfigManageTableValueTypeSection
}CFLAppConfigManageTableValueType;

//Interface definition
@interface CFLAppConfigManageTableValue : NSObject

@property (nonatomic, strong, readonly) NSString *config;
@property (nonatomic, strong, readonly) NSString *labelString;
@property (nonatomic, assign, readonly) CFLAppConfigManageTableValueType type;

+ (CFLAppConfigManageTableValue *)valueForLoading:(NSString *)loadingText;
+ (CFLAppConfigManageTableValue *)valueForConfig:(NSString *)configName andText:(NSString *)configNameLabel;
+ (CFLAppConfigManageTableValue *)valueForInfo:(NSString *)infoText;
+ (CFLAppConfigManageTableValue *)valueForSection:(NSString *)sectionText;

- (NSString *)cellIdentifier;

@end
