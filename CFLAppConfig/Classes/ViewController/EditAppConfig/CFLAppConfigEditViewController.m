//
//  CFLAppConfigEditViewController.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigEditViewController.h"
#import "CFLAppConfigStorage.h"
#import "CFLAppConfigBundle.h"

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
    if (self.newConfig)
    {
        [self.navigationItem setTitle:[CFLAppConfigBundle localizedString:@"CFLAC_EDIT_NEW_TITLE"]];
    }
    else
    {
        [self.navigationItem setTitle:[CFLAppConfigBundle localizedString:@"CFLAC_EDIT_TITLE"]];
    }
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
        [saveButton setTitle:[CFLAppConfigBundle localizedString:@"CFLAC_SHARED_SAVE"] forState:UIControlStateNormal];
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
        if ([[CFLAppConfigStorage sharedStorage] configManager])
        {
            [self.editConfigTable setConfigurationSettings:[self obtainSettings] forConfig:self.configName withModel:[[[CFLAppConfigStorage sharedStorage] configManager] obtainBaseModelInstance]];
        }
        else
        {
            [self.editConfigTable setConfigurationSettings:[self obtainSettings] forConfig:self.configName];
        }
    }];
}

- (void)loadView
{
    self.editConfigTable = [CFLAppConfigEditTable new];
    self.editConfigTable.parentViewController = self;
    self.editConfigTable.newConfig = self.newConfig;
    self.editConfigTable.delegate = self;
    self.view = self.editConfigTable;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark Helpers

- (NSDictionary *)obtainSettings
{
    NSMutableDictionary *settings = [[[CFLAppConfigStorage sharedStorage] configSettingsNotNull:self.configName] mutableCopy];
    if (self.newConfig)
    {
        settings[@"name"] = [NSString stringWithFormat:@"%@ %@", self.configName, [CFLAppConfigBundle localizedString:@"CFLAC_EDIT_COPY_SUFFIX"]];
    }
    return settings;
}


#pragma mark Selectors

- (void)saveButtonPressed
{
    [self saveConfig:[self.editConfigTable obtainNewConfigurationSettings]];
}


#pragma mark CFLAppConfigEditTableDelegate

- (void)saveConfig:(NSDictionary *)newSettings
{
    BOOL wasSelected = [self.configName isEqualToString:[[CFLAppConfigStorage sharedStorage] selectedConfig]];
    if ([[CFLAppConfigStorage sharedStorage] isCustomConfig:self.configName] || [[CFLAppConfigStorage sharedStorage] isConfigOverride:self.configName])
    {
        [[CFLAppConfigStorage sharedStorage] removeConfig:self.configName];
    }
    [[CFLAppConfigStorage sharedStorage] putCustomConfig:newSettings forConfig:newSettings[@"name"]];
    if (wasSelected)
    {
        [[CFLAppConfigStorage sharedStorage] selectConfig:newSettings[@"name"]];
    }
    [[CFLAppConfigStorage sharedStorage] synchronizeCustomConfigWithUserDefaults:newSettings[@"name"]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelEditing
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)revertConfig
{
    BOOL wasSelected = [self.configName isEqualToString:[[CFLAppConfigStorage sharedStorage] selectedConfig]];
    if ([[CFLAppConfigStorage sharedStorage] isCustomConfig:self.configName] || [[CFLAppConfigStorage sharedStorage] isConfigOverride:self.configName])
    {
        [[CFLAppConfigStorage sharedStorage] removeConfig:self.configName];
        [[CFLAppConfigStorage sharedStorage] synchronizeCustomConfigWithUserDefaults:self.configName];
    }
    if (wasSelected)
    {
        [[CFLAppConfigStorage sharedStorage] selectConfig:self.configName];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
