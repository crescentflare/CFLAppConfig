//
//  CFLAppConfigEditViewController.h
//  CFLAppConfig Pod
//
//  Library view controller: edit configuration
//  Be able to change the given configuration
//

//Import
@import UIKit;
#import "CFLAppConfigEditTable.h"

//Interface definition
@interface CFLAppConfigEditViewController : UIViewController <CFLAppConfigEditTableDelegate>

@property (nonatomic, strong) NSString *configName;
@property (nonatomic, assign) BOOL newConfig;

@end
