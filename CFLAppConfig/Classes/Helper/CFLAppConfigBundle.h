//
//  CFLAppConfigBundle.h
//  CFLAppConfig Pod
//
//  Library helper: bundle access utility
//  Provides helper functions to acquire resources from the Pod bundle (like images and strings)
//

//Import
@import Foundation;
@import UIKit;

//Interface definition
@interface CFLAppConfigBundle : NSObject

+ (UIImage *)imageNamed:(NSString *)image;
+ (NSString *)localizedString:(NSString *)key;

@end
