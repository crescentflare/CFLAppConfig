//
//  CFLAppConfigBundle.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigBundle.h"

//Internal interface definition
@interface CFLAppConfigBundle ()

@end

//Interface implementation
@implementation CFLAppConfigBundle

#pragma mark Internal helpers

+ (NSBundle *)podBundle
{
    return [NSBundle bundleWithURL:[[NSBundle bundleForClass:[self class]] URLForResource:@"CFLAppConfig" withExtension:@"bundle"]];
}

#pragma mark Implementation

+ (UIImage *)imageNamed:(NSString *)image
{
    return [UIImage imageNamed:image inBundle:[CFLAppConfigBundle podBundle] compatibleWithTraitCollection:nil];
}

+ (NSString *)localizedString:(NSString *)key
{
    return NSLocalizedStringFromTableInBundle(key, @"Localizable", [CFLAppConfigBundle podBundle], nil);
}

@end
