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

//Delegate protocol
@protocol CFLAppConfigManageTableDelegate <NSObject>

- (void)selectedConfig:(NSString *)configName;
- (void)editConfig:(NSString *)configName;

@end

//Interface definition
@interface CFLAppConfigManageTable : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<CFLAppConfigManageTableDelegate> delegate;

- (void)setConfigurations:(NSArray *)configurations lastSelected:(NSString *)lastSelectedConfig;

@end
