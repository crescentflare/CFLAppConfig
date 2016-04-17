//
//  CFLViewController.h
//  CFLAppConfig Example
//
//  A simple screen which launches the app config selection screen
//  It will show the selected values on-screen
//

//Imports
@import UIKit;
#import "CFLAppConfigManageViewController.h"

//Interface definition
@interface CFLViewController : UIViewController <CFLAppConfigManageViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *selectedConfigLabel;
@property (strong, nonatomic) IBOutlet UILabel *apiUrlLabel;
@property (strong, nonatomic) IBOutlet UILabel *runTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *sslSettingLabel;
@property (strong, nonatomic) IBOutlet UILabel *networkTimeoutLabel;

@end
