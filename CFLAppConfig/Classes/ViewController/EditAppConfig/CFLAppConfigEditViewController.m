//
//  CFLAppConfigEditViewController.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigEditViewController.h"
#import "CFLAppConfigStorage.h"

//Internal interface definition
@interface CFLAppConfigEditViewController ()

@property (nonatomic, strong) CFLAppConfigEditTable *editConfigTable;

@end

//Interface implementation
@implementation CFLAppConfigEditViewController

#pragma mark Lifecycle

- (void)viewDidLoad
{
    //Set title
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Edit configuration", nil)];
    self.navigationController.navigationBar.translucent = NO;
    
    //Add an easy-reachable save button to the navigation bar
    if (self.navigationController)
    {
        //Obtain colors
        CGFloat tintR, tintG, tintB, tintA;
        UIColor *tintColor = self.view.tintColor;
        [tintColor getRed:&tintR green:&tintG blue:&tintB alpha:&tintA];
        UIColor *highlightTintColor = [UIColor colorWithRed:tintR green:tintG blue:tintB alpha:0.25f];

        //Create button
        UIButton *saveButton = [UIButton new];
        [saveButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [saveButton setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
        [saveButton setTitleColor:tintColor forState:UIControlStateNormal];
        [saveButton setTitleColor:highlightTintColor forState:UIControlStateHighlighted];
        [saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = [saveButton sizeThatFits:CGSizeZero];
        saveButton.frame = CGRectMake(0, 0, size.width, size.height);
        
        //Wrap in bar button item
        UIBarButtonItem *saveButtonWrapper = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
        [self.navigationItem setRightBarButtonItem:saveButtonWrapper];
    }
    
    //Update configuration list
    [[CFLAppConfigStorage sharedStorage] loadFromSource:^(){
        NSDictionary *settings = [[CFLAppConfigStorage sharedStorage] configSettingsNotNull:self.configName];
        if ([[CFLAppConfigStorage sharedStorage] configManager])
        {
            [self.editConfigTable setConfigurationSettings:settings forConfig:self.configName withModel:[[[CFLAppConfigStorage sharedStorage] configManager] obtainBaseModelInstance]];
        }
        else
        {
            [self.editConfigTable setConfigurationSettings:settings forConfig:self.configName];
        }
    }];
}

- (void)loadView
{
    self.editConfigTable = [CFLAppConfigEditTable new];
    self.editConfigTable.delegate = self;
    self.view = self.editConfigTable;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark Selectors

- (void)saveButtonPressed
{
    [self saveConfig];
}


#pragma mark CFLAppConfigEditTableDelegate

- (void)saveConfig
{
    [[[UIAlertView alloc] initWithTitle:@"Not supported" message:@"Editing is not fully supported yet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelEditing
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
