//
//  CFLAppConfigEditTextCell.h
//  CFLAppConfig Pod
//
//  Library table cell view: edit configuration
//  Custom table cell view for displaying an editable textfield cell
//  Used internally
//

//Import
@import UIKit;

//Interface definition
@interface CFLAppConfigEditTextCell : UIView <UITextFieldDelegate>

@property (nonatomic) NSString *labelText;
@property (nonatomic) NSString *editedText;
@property (nonatomic) BOOL numbersOnly;

- (void)startEditing;

@end
