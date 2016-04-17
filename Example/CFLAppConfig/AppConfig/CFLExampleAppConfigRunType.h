//
//  CFLExampleAppConfigRunType.h
//  CFLAppConfig Example
//
//  App config: application configuration run setting
//  An enum used by the application build configuration
//

//Imports
@import Foundation;
@import CFLAppConfig;

//Enum definition
typedef enum
{
    CFLExampleAppConfigRunTypeNormally = 0,
    CFLExampleAppConfigRunTypeQuickly,
    CFLExampleAppConfigRunTypeStrictly
}CFLExampleAppConfigRunType;

//Interface definition
@interface CFLExampleAppConfigRunTypeSerializer : CFLAppConfigEnumSerializer

@end
