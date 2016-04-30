//
//  CFLAppConfigEditTable.h
//  CFLAppConfig Pod
//
//  Library table: edit configuration
//  The table view and data source for the edit config viewcontroller
//  Used internally
//

//Import
@import UIKit;
#import "CFLAppConfigBaseModel.h"
#import "CFLAppConfigSelectionHelperViewController.h"
#import "CFLAppConfigEditTextCell.h"
#import "CFLAppConfigEditSliderCell.h"

//Delegate protocol
@protocol CFLAppConfigEditTableDelegate <NSObject>

- (void)saveConfig:(NSDictionary *)newSettings;
- (void)cancelEditing;

@end

//Interface definition
@interface CFLAppConfigEditTable : UIView <UITableViewDataSource, UITableViewDelegate, CFLAppConfigSelectionHelperViewControllerDelegate, CFLAppConfigEditTextCellDelegate, CFLAppConfigEditSliderCellDelegate>

@property (nonatomic, weak) id<CFLAppConfigEditTableDelegate> delegate;
@property (nonatomic, weak) UIViewController *parentViewController;

- (void)setConfigurationSettings:(NSDictionary *)configurationSettings forConfig:(NSString *)configName;
- (void)setConfigurationSettings:(NSDictionary *)configurationSettings forConfig:(NSString *)configName withModel:(CFLAppConfigBaseModel *)model;
- (NSDictionary *)obtainNewConfigurationSettings;

@end
