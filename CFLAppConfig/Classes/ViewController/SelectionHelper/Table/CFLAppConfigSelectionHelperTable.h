//
//  CFLAppConfigSelectionHelperTable.h
//  CFLAppConfig Pod
//
//  Library table: selection helper
//  The table view and data source for the selection helper viewcontroller
//  Used internally
//

//Import
@import UIKit;

//Delegate protocol
@protocol CFLAppConfigSelectionHelperTableDelegate <NSObject>

- (void)chosenItem:(NSString *)choice;

@end

//Interface definition
@interface CFLAppConfigSelectionHelperTable : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<CFLAppConfigSelectionHelperTableDelegate> delegate;

- (void)setChoices:(NSArray *)choices;

@end
