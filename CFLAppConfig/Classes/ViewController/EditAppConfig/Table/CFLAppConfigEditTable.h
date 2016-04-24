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

//Delegate protocol
@protocol CFLAppConfigEditTableDelegate <NSObject>

- (void)saveConfig;
- (void)cancelEditing;

@end

//Interface definition
@interface CFLAppConfigEditTable : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<CFLAppConfigEditTableDelegate> delegate;

- (void)setConfigurationSettings:(NSDictionary *)configurationSettings forConfig:(NSString *)configName;
- (void)setConfigurationSettings:(NSDictionary *)configurationSettings forConfig:(NSString *)configName withModel:(CFLAppConfigBaseModel *)model;

@end
