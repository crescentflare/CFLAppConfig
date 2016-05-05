//
//  CFLAppConfigSelectionHelperTableCell.h
//  CFLAppConfig Pod
//
//  Library table cell: selection helper
//  Custom table view cell with layout for the selection helper viewcontroller
//  Used internally
//

//Import
@import UIKit;

//Interface definition
@interface CFLAppConfigSelectionHelperTableCell : UITableViewCell

@property (nonatomic) UIView *cellView;
@property (nonatomic, assign) BOOL shouldHideDivider;

@end
