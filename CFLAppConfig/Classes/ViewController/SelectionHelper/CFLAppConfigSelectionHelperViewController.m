//
//  CFLAppConfigSelectionHelperViewController.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigSelectionHelperViewController.h"
#import "CFLAppConfigStorage.h"
#import "CFLAppConfigBundle.h"

//Internal interface definition
@interface CFLAppConfigSelectionHelperViewController ()

@property (nonatomic, strong) CFLAppConfigSelectionHelperTable *selectionTable;

@end

//Interface implementation
@implementation CFLAppConfigSelectionHelperViewController

#pragma mark Lifecycle

- (void)viewDidLoad
{
    //Set title
    [super viewDidLoad];
    [self.navigationItem setTitle:[CFLAppConfigBundle localizedString:@"CFLAC_SHARED_SELECT_MENU"]];
    self.navigationController.navigationBar.translucent = NO;
    
    //Always use a cancel button (when having a navigation bar)
    if (self.navigationController)
    {
        //Obtain colors
        CGFloat tintR, tintG, tintB, tintA;
        UIColor *tintColor = self.view.tintColor;
        [tintColor getRed:&tintR green:&tintG blue:&tintB alpha:&tintA];
        UIColor *highlightTintColor = [UIColor colorWithRed:tintR green:tintG blue:tintB alpha:0.25f];
        
        //Create button
        UIButton *cancelButton = [UIButton new];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelButton setTitle:[CFLAppConfigBundle localizedString:@"CFLAC_SHARED_CANCEL"] forState:UIControlStateNormal];
        [cancelButton setTitleColor:tintColor forState:UIControlStateNormal];
        [cancelButton setTitleColor:highlightTintColor forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = [cancelButton sizeThatFits:CGSizeZero];
        cancelButton.frame = CGRectMake(0, 0, size.width, size.height);
        
        //Wrap in bar button item
        UIBarButtonItem *cancelButtonWrapper = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
        [self.navigationItem setLeftBarButtonItem:cancelButtonWrapper];
    }

    //Update selection list
    [self.selectionTable setChoices:self.choices];
}

- (void)loadView
{
    self.selectionTable = [CFLAppConfigSelectionHelperTable new];
    self.selectionTable.delegate = self;
    self.view = self.selectionTable;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark Selectors

- (void)cancelButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark CFLAppConfigSelectionHelperTableDelegate

- (void)chosenItem:(NSString *)choice
{
    [self.navigationController popViewControllerAnimated:!self.preventAnimateOnClose];
    if (self.delegate)
    {
        [self.delegate chosenItem:choice givenTag:self.tag];
    }
}

@end
