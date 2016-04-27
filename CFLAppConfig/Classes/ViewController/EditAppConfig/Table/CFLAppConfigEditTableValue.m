//
//  CFLAppConfigEditTableValue.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigEditTableValue.h"

//Internal interface definition
@interface CFLAppConfigEditTableValue ()
@end

//Interface implementation
@implementation CFLAppConfigEditTableValue

#pragma mark Initializing

- (id)initWithType:(CFLAppConfigEditTableValueType)type andAction:(CFLAppConfigEditTableValueAction)action andChoices:(NSArray *)choices andSetting:(NSString *)setting andLabelString:(NSString *)labelString andBooleanValue:(BOOL)booleanValue andLimitUsage:(BOOL)limitUsage
{
    self = [super init];
    if (self)
    {
        _type = type;
        _action = action;
        _choices = choices;
        _configSetting = setting;
        _labelString = labelString;
        _booleanValue = booleanValue;
        _limitUsage = limitUsage;
    }
    return self;
}


#pragma mark Factory methods

+ (CFLAppConfigEditTableValue *)valueForLoading:(NSString *)loadingText
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeLoading andAction:CFLAppConfigEditTableValueTypeUnknown andChoices:nil andSetting:nil andLabelString:loadingText andBooleanValue:NO andLimitUsage:NO];
}

+ (CFLAppConfigEditTableValue *)valueForAction:(CFLAppConfigEditTableValueAction)action andText:(NSString *)actionLabel
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeAction andAction:action andChoices:nil andSetting:nil andLabelString:actionLabel andBooleanValue:NO andLimitUsage:NO];
}

+ (CFLAppConfigEditTableValue *)valueForEditText:(NSString *)configSetting andValue:(NSString *)settingValue numberOnly:(BOOL)onlyNumbers
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeEditText andAction:CFLAppConfigEditTableValueTypeUnknown andChoices:nil andSetting:configSetting andLabelString:settingValue andBooleanValue:NO andLimitUsage:onlyNumbers];
}

+ (CFLAppConfigEditTableValue *)valueForSlider:(NSString *)configSetting andSwitchedOn:(BOOL)settingValue
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeSlider andAction:CFLAppConfigEditTableValueTypeUnknown andChoices:nil andSetting:configSetting andLabelString:nil andBooleanValue:settingValue andLimitUsage:NO];
}

+ (CFLAppConfigEditTableValue *)valueForSelection:(NSString *)configSetting andValue:(NSString *)settingValue andChoices:(NSString *)choices
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeSelection andAction:CFLAppConfigEditTableValueTypeUnknown andChoices:choices andSetting:configSetting andLabelString:settingValue andBooleanValue:NO andLimitUsage:NO];
}

+ (CFLAppConfigEditTableValue *)valueForSection:(NSString *)sectionText
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeSection andAction:CFLAppConfigEditTableValueTypeUnknown andChoices:nil andSetting:nil andLabelString:sectionText andBooleanValue:NO andLimitUsage:NO];
}


#pragma mark Implementation

- (NSString *)cellIdentifier
{
    switch (_type)
    {
        case CFLAppConfigEditTableValueTypeLoading:
            return @"CFLAppConfigEditTableValueTypeLoading";
        case CFLAppConfigEditTableValueTypeAction:
            return @"CFLAppConfigEditTableValueTypeAction";
        case CFLAppConfigEditTableValueTypeEditText:
            return @"CFLAppConfigEditTableValueTypeEditText";
        case CFLAppConfigEditTableValueTypeSlider:
            return @"CFLAppConfigEditTableValueTypeSlider";
        case CFLAppConfigEditTableValueTypeSelection:
            return @"CFLAppConfigEditTableValueTypeSelection";
        case CFLAppConfigEditTableValueTypeSection:
            return @"CFLAppConfigEditTableValueTypeSection";
        default:
            break;
    }
    return @"CFLAppConfigEditTableValueTypeUnknown";
}

@end
