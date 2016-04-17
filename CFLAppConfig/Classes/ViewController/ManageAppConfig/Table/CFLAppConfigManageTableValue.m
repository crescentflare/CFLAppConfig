//
//  CFLAppConfigManageTableValue.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigManageTableValue.h"

//Internal interface definition
@interface CFLAppConfigManageTableValue ()
@end

//Interface implementation
@implementation CFLAppConfigManageTableValue

#pragma mark Initializing

- (id)initWithType:(CFLAppConfigManageTableValueType)type andConfig:(NSString *)config andLabelString:(NSString *)labelString
{
    self = [super init];
    if (self)
    {
        _type = type;
        _config = config;
        _labelString = labelString;
    }
    return self;
}


#pragma mark Factory methods

+ (CFLAppConfigManageTableValue *)valueForLoading:(NSString *)loadingText
{
    return [[CFLAppConfigManageTableValue alloc] initWithType:CFLAppConfigManageTableValueTypeLoading andConfig:nil andLabelString:loadingText];
}

+ (CFLAppConfigManageTableValue *)valueForConfig:(NSString *)configName andText:(NSString *)configNameLabel
{
    return [[CFLAppConfigManageTableValue alloc] initWithType:CFLAppConfigManageTableValueTypeConfig andConfig:configName andLabelString:configNameLabel];
}

+ (CFLAppConfigManageTableValue *)valueForInfo:(NSString *)infoText
{
    return [[CFLAppConfigManageTableValue alloc] initWithType:CFLAppConfigManageTableValueTypeInfo andConfig:nil andLabelString:infoText];
}

+ (CFLAppConfigManageTableValue *)valueForSection:(NSString *)sectionText
{
    return [[CFLAppConfigManageTableValue alloc] initWithType:CFLAppConfigManageTableValueTypeSection andConfig:nil andLabelString:sectionText];
}


#pragma mark Implementation

- (NSString *)cellIdentifier
{
    switch (_type)
    {
        case CFLAppConfigManageTableValueTypeLoading:
            return @"CFLAppConfigManageTableValueTypeLoading";
        case CFLAppConfigManageTableValueTypeConfig:
            return @"CFLAppConfigManageTableValueTypeConfig";
        case CFLAppConfigManageTableValueTypeInfo:
            return @"CFLAppConfigManageTableValueTypeInfo";
        case CFLAppConfigManageTableValueTypeSection:
            return @"CFLAppConfigManageTableValueTypeSection";
        default:
            break;
    }
    return @"CFLAppConfigManageTableValueTypeUnknown";
}

@end
