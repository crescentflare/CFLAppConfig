//
//  CFLAppConfigSelectionHelperViewController.h
//  CFLAppConfig Pod
//
//  Library view controller: selection helper
//  Presents a list of strings to make a selection from
//

//Import
@import UIKit;
#import "CFLAppConfigSelectionHelperTable.h"

//Delegate protocol
@protocol CFLAppConfigSelectionHelperViewControllerDelegate <NSObject>

- (void)chosenItem:(NSString *)item givenTag:(NSObject *)tag;

@end

//Interface definition
@interface CFLAppConfigSelectionHelperViewController : UIViewController <CFLAppConfigSelectionHelperTableDelegate>

@property (nonatomic, weak) id<CFLAppConfigSelectionHelperViewControllerDelegate> delegate;
@property (nonatomic, strong) NSObject *tag;
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, assign) BOOL preventAnimateOnClose;

@end
