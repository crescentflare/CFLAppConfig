//
//  CFLAppConfigEditTableCell.h
//  CFLAppConfig Pod
//
//  Library table cell: edit configuration
//  Custom table view cell with layout for the edit config viewcontroller
//  Used internally
//

//Import
@import UIKit;

//Interface definition
@interface CFLAppConfigEditTableCell : UITableViewCell

@property (nonatomic) UIView *cellView;
@property (nonatomic, assign) BOOL shouldHideDivider;

@end
