//
//  CFLAppConfigManageViewController.h
//  CFLAppConfig Pod
//
//  Library view controller: managing configurations
//  Be able to select, add and edit app configurations
//

//Import
@import UIKit;
#import "CFLAppConfigManageTable.h"

//Delegate protocol
@protocol CFLAppConfigManageViewControllerDelegate <NSObject>

- (void)configChosen;
- (void)configCanceled;

@end

//Interface definition
@interface CFLAppConfigManageViewController : UIViewController <CFLAppConfigManageTableDelegate>

@property (nonatomic, weak) id<CFLAppConfigManageViewControllerDelegate> delegate;

@end
