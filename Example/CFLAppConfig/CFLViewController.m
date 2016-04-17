//
//  CFLViewController.m
//  CFLAppConfig Example
//

#import "CFLViewController.h"
#import "CFLAppConfigStorage.h"
#import "CFLExampleAppConfigManager.h"

@interface CFLViewController ()

- (IBAction)changeConfiguration:(id)sender;

@end

@implementation CFLViewController

#pragma Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateConfigurationValues];
    [[CFLAppConfigStorage sharedStorage] addDataObserver:self selector:@selector(updateConfigurationValues) name:kAppConfigConfigurationChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[CFLAppConfigStorage sharedStorage] removeDataObserver:self name:kAppConfigConfigurationChanged];
}


#pragma Helper

- (void)updateConfigurationValues
{
    self.selectedConfigLabel.text = [CFLExampleAppConfigManager currentConfig].name;
    self.apiUrlLabel.text = [CFLExampleAppConfigManager currentConfig].apiUrl;
    self.runTypeLabel.text = [CFLExampleAppConfigRunTypeSerializer fromEnumValue:[CFLExampleAppConfigManager currentConfig].runType];
    self.sslSettingLabel.text = [CFLExampleAppConfigManager currentConfig].acceptAllSSL ? @"Yes" : @"No";
    self.networkTimeoutLabel.text = [NSString stringWithFormat:@"%d", [CFLExampleAppConfigManager currentConfig].networkTimeoutSec];
}


#pragma Selector

- (IBAction)changeConfiguration:(id)sender
{
    CFLAppConfigManageViewController *viewController = [CFLAppConfigManageViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.delegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}


#pragma CFLAppConfigManageViewControllerDelegate

- (void)configChosen
{
    //Add optional extra handling here
}

- (void)configCanceled
{
    //Add optional extra handling here
}

@end
