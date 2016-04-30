//
//  CFLAppConfigEditSliderCell.h
//  CFLAppConfig Pod
//
//  Library table cell view: edit configuration
//  Custom table cell view for displaying a slider cell
//  Used internally
//

//Import
@import UIKit;

//Delegate protocol
@protocol CFLAppConfigEditSliderCellDelegate <NSObject>

- (void)changedSliderState:(BOOL)on forConfigSetting:(NSString *)configSetting;

@end

//Interface definition
@interface CFLAppConfigEditSliderCell : UIView

@property (nonatomic, weak) id<CFLAppConfigEditSliderCellDelegate> delegate;
@property (nonatomic) NSString *labelText;
@property (nonatomic) BOOL on;

- (void)toggleState;

@end
