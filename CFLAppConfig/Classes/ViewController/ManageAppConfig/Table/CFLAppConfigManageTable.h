//
//  CFLAppConfigManageTable.h
//  CFLAppConfig Pod
//
//  Library table: managing configurations
//  The table view and data source for the manage config viewcontroller
//  Used internally
//

//Import
@import UIKit;
#import "CFLAppConfigSelectionHelperViewController.h"

//Delegate protocol
@protocol CFLAppConfigManageTableDelegate <NSObject>

- (void)selectedConfig:(NSString *)configName;
- (void)editConfig:(NSString *)configName;
- (void)newCustomConfigFrom:(NSString *)originalConfigName;

@end

//Interface definition
@interface CFLAppConfigManageTable : UIView <UITableViewDataSource, UITableViewDelegate, CFLAppConfigSelectionHelperViewControllerDelegate>

@property (nonatomic, weak) id<CFLAppConfigManageTableDelegate> delegate;
@property (nonatomic, weak) UIViewController *parentViewController;

- (void)setConfigurations:(NSArray *)configurations customConfigs:(NSArray *)customConfigurations lastSelected:(NSString *)lastSelectedConfig;

@end
