//
//  CFLAppConfigManageTableCell.h
//  CFLAppConfig Pod
//
//  Library table cell: managing configurations
//  Custom table view cell with layout for the manage config viewcontroller
//  Used internally
//

//Import
@import UIKit;

//Interface definition
@interface CFLAppConfigManageTableCell : UITableViewCell

@property (nonatomic) UIView *cellView;
@property (nonatomic, assign) BOOL shouldHideDivider;

@end
