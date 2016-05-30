//
//  CFLAppConfigStorage.h
//  CFLAppConfig Pod
//
//  Library manager: storage class
//  Contains app config storage and provides the main interface
//

//Import
@import Foundation;
#import "CFLAppConfigBaseManager.h"

//Observers
#define kAppConfigConfigurationChanged @"kAppConfigConfigurationChanged"

//Interface definition
@interface CFLAppConfigStorage : NSObject

//This class is a singleton
+ (CFLAppConfigStorage *)sharedStorage;

//Initialize storage, call this when using the selection menu
//(optionally) specify the custom manager implementation to use
- (void)initialize;
- (void)initialize:(CFLAppConfigBaseManager *)manager;

//Determine if the storage has been initialized
//Useful to determine if the storage is being used or not to override the configuration (for test/production builds)
- (BOOL)isInitialized;

//Obtain manager instance, only used internally if the given manager is a singleton (which is recommended)
- (CFLAppConfigBaseManager *)configManager;

//Return settings for the given configuration
- (NSDictionary *)configSettings:(NSString *)config;
- (NSDictionary *)configSettingsNotNull:(NSString *)config;

//Return the currently selected config, can be nil
- (NSString *)selectedConfig;

//Obtain a list of loaded configurations
- (NSArray *)obtainConfigList;
- (NSArray *)obtainCustomConfigList;

//Set custom values for an existing or new configuration
- (void)putCustomConfig:(NSDictionary *)settings forConfig:(NSString *)config;

//Remove a configuration
- (BOOL)removeConfig:(NSString *)config;

//Select a configuration
- (void)selectConfig:(NSString *)configName;

//Return information about type and state of configuration
- (BOOL)isCustomConfig:(NSString *)config;
- (BOOL)isConfigOverride:(NSString *)config;

//Supply the path of the file containing the overrides
//Should point to a plist file
//The file is only loaded when the selection screen is opened
- (void)setLoadingSourceAssetFile:(NSString *)filePath;

//Internal method: load configurations from specified source
- (void)loadFromSource:(void (^)())completion;
- (void)loadFromSourceSync;

//Internal method: synchronize customized configuration with user defaults
- (void)synchronizeCustomConfigWithUserDefaults:(NSString *)config;

//Add/remove observer for configuration changes
- (void)addDataObserver:(id)observer selector:(SEL)selector name:(NSString *)identifier;
- (void)removeDataObserver:(id)observer name:(NSString *)identifier;

@end
