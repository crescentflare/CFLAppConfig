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

- (id)initWithType:(CFLAppConfigEditTableValueType)type andAction:(CFLAppConfigEditTableValueAction)action andSetting:(NSString *)setting andLabelString:(NSString *)labelString andBooleanValue:(BOOL)booleanValue
{
    self = [super init];
    if (self)
    {
        _type = type;
        _action = action;
        _configSetting = setting;
        _labelString = labelString;
        _booleanValue = booleanValue;
    }
    return self;
}


#pragma mark Factory methods

+ (CFLAppConfigEditTableValue *)valueForLoading:(NSString *)loadingText
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeLoading andAction:CFLAppConfigEditTableValueTypeUnknown andSetting:nil andLabelString:loadingText andBooleanValue:NO];
}

+ (CFLAppConfigEditTableValue *)valueForAction:(CFLAppConfigEditTableValueAction)action andText:(NSString *)actionLabel
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeAction andAction:action andSetting:nil andLabelString:actionLabel andBooleanValue:NO];
}

+ (CFLAppConfigEditTableValue *)valueForEditText:(NSString *)configSetting andValue:(NSString *)settingValue
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeEditText andAction:CFLAppConfigEditTableValueTypeUnknown andSetting:configSetting andLabelString:settingValue andBooleanValue:NO];
}

+ (CFLAppConfigEditTableValue *)valueForSlider:(NSString *)configSetting andSwitchedOn:(BOOL)settingValue
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeSlider andAction:CFLAppConfigEditTableValueTypeUnknown andSetting:configSetting andLabelString:nil andBooleanValue:settingValue];
}

+ (CFLAppConfigEditTableValue *)valueForSelection:(NSString *)configSetting andValue:(NSString *)settingValue
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeSelection andAction:CFLAppConfigEditTableValueTypeUnknown andSetting:configSetting andLabelString:settingValue andBooleanValue:NO];
}

+ (CFLAppConfigEditTableValue *)valueForSection:(NSString *)sectionText
{
    return [[CFLAppConfigEditTableValue alloc] initWithType:CFLAppConfigEditTableValueTypeSection andAction:CFLAppConfigEditTableValueTypeUnknown andSetting:nil andLabelString:sectionText andBooleanValue:NO];
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
