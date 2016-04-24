//
//  CFLAppConfigManageViewController.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigManageViewController.h"
#import "CFLAppConfigStorage.h"
#import "CFLAppConfigEditViewController.h"

//Internal interface definition
@interface CFLAppConfigManageViewController ()

@property (nonatomic, assign) BOOL isPresentedController;
@property (nonatomic, strong) CFLAppConfigManageTable *manageConfigTable;

@end

//Interface implementation
@implementation CFLAppConfigManageViewController

#pragma mark Lifecycle

- (void)viewDidLoad
{
    //Set title
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"App configurations", nil)];
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
        [cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [cancelButton setTitleColor:tintColor forState:UIControlStateNormal];
        [cancelButton setTitleColor:highlightTintColor forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = [cancelButton sizeThatFits:CGSizeZero];
        cancelButton.frame = CGRectMake(0, 0, size.width, size.height);
        
        //Wrap in bar button item
        UIBarButtonItem *cancelButtonWrapper = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
        [self.navigationItem setLeftBarButtonItem:cancelButtonWrapper];
    }
    
    //Update configuration list
    [[CFLAppConfigStorage sharedStorage] loadFromSource:^(){
        [self.manageConfigTable setConfigurations:[[CFLAppConfigStorage sharedStorage] obtainConfigList] lastSelected:[[CFLAppConfigStorage sharedStorage] selectedConfig]];
    }];
}

- (void)loadView
{
    if (self.navigationController)
    {
        self.isPresentedController = [self.navigationController isBeingPresented];
    }
    else
    {
        self.isPresentedController = [self isBeingPresented];
    }
    self.manageConfigTable = [CFLAppConfigManageTable new];
    self.manageConfigTable.delegate = self;
    self.view = self.manageConfigTable;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark Selectors

- (void)cancelButtonPressed
{
    if (self.isPresentedController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.delegate)
    {
        [self.delegate configCanceled];
    }
}


#pragma mark CFLAppConfigManageTableDelegate

- (void)selectedConfig:(NSString *)configName
{
    [[CFLAppConfigStorage sharedStorage] selectConfig:configName];
    if (self.isPresentedController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.delegate)
    {
        [self.delegate configChosen];
    }
}

- (void)editConfig:(NSString *)configName
{
    if (self.navigationController)
    {
        CFLAppConfigEditViewController *viewController = [CFLAppConfigEditViewController new];
        viewController.configName = configName;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
