//
//  CFLAppConfigStorage.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigStorage.h"
#import "CFLAppConfigOrderedDictionary.h"

//Definitions
#define kDefaultsSelectedConfigName @"CFLAppConfig_SelectedConfigName"
#define kDefaultsSelectedConfigDictionary @"CFLAppConfig_SelectedConfigDictionary"

//Internal interface definition
@interface CFLAppConfigStorage ()

@property (nonatomic, strong) CFLAppConfigBaseManager *configManager;
@property (nonatomic, strong) CFLAppConfigOrderedDictionary *storedConfigs;
@property (nonatomic, strong) NSString *loadFromAssetFile;
@property (nonatomic, strong) NSString *selectedItem;
@property (nonatomic, assign) BOOL initialized;

@end

//Interface implementation
@implementation CFLAppConfigStorage

#pragma mark Initialization

+ (CFLAppConfigStorage *)sharedStorage
{
    static CFLAppConfigStorage *_sharedStorage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStorage = [[CFLAppConfigStorage alloc] init];
    });
    return _sharedStorage;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.storedConfigs = [CFLAppConfigOrderedDictionary new];
    }
    return self;
}

- (void)initialize
{
    [self initialize:nil];
}

- (void)initialize:(CFLAppConfigBaseManager *)manager
{
    self.configManager = manager;
    [self loadSelectedItemFromUserDefaults];
    if (manager && self.selectedItem && self.storedConfigs[self.selectedItem])
    {
        [manager applyConfigToModel:self.storedConfigs[self.selectedItem] withName:self.selectedItem];
    }
    self.initialized = YES;
}

- (BOOL)isInitialized
{
    return self.initialized;
}


#pragma mark Internal manager access

- (CFLAppConfigBaseManager *)configManager
{
    return _configManager;
}


#pragma mark Obtain from storage

- (NSDictionary *)configSettings:(NSString *)config
{
    return [self.storedConfigs objectForKey:config];
}

- (NSDictionary *)configSettingsNotNull:(NSString *)config
{
    NSDictionary *settings = [self configSettings:config];
    if (!settings)
    {
        settings = @{};
    }
    return settings;
}

- (NSString *)selectedConfig
{
    return self.selectedItem;
}

- (NSArray *)obtainConfigList
{
    NSMutableArray *list = [NSMutableArray new];
    for (NSString *key in self.storedConfigs)
    {
        [list addObject:key];
    }
    return list;
}


#pragma mark Other operations

- (void)selectConfig:(NSString *)configName
{
    self.selectedItem = nil;
    for (NSString *key in self.storedConfigs)
    {
        if ([key isEqualToString:configName])
        {
            self.selectedItem = configName;
            break;
        }
    }
    [self storeSelectedItemInUserDefaults];
    if (self.configManager)
    {
        NSDictionary *config = nil;
        if (self.selectedItem)
        {
            config = self.storedConfigs[self.selectedItem];
        }
        if (!config)
        {
            config = @{};
        }
        [self.configManager applyConfigToModel:config withName:self.selectedItem];
    }
    [NSNotificationCenter.defaultCenter postNotificationName:kAppConfigConfigurationChanged object:self];
}


#pragma mark Loading

- (void)setLoadingSourceAssetFile:(NSString *)filePath
{
    self.loadFromAssetFile = filePath;
}

- (void)loadFromSource:(void (^)())completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        CFLAppConfigOrderedDictionary *loadedConfigs = [self loadFromSourceInternal:self.loadFromAssetFile];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (loadedConfigs)
            {
                self.storedConfigs = loadedConfigs;
                self.loadFromAssetFile = nil;
            }
            completion();
        });
    });
}

- (void)loadFromSourceSync
{
    CFLAppConfigOrderedDictionary *loadedConfigs = [self loadFromSourceInternal:self.loadFromAssetFile];
    if (loadedConfigs)
    {
        self.storedConfigs = loadedConfigs;
        self.loadFromAssetFile = nil;
    }
}

- (CFLAppConfigOrderedDictionary *)loadFromSourceInternal:(NSString *)fileName
{
    if (fileName)
    {
        NSArray *loadedArray = [[NSArray alloc] initWithContentsOfFile:fileName];
        if (loadedArray && [loadedArray count] > 0)
        {
            //Obtain default item with values from manager model (if applicable)
            NSMutableDictionary *defaultItem = nil;
            if (self.configManager)
            {
                CFLAppConfigBaseModel *model = [self.configManager obtainBaseModelInstance];
                if (model)
                {
                    NSDictionary *values = [model obtainValueTypes];
                    if (values && [values count] > 0)
                    {
                        defaultItem = [NSMutableDictionary new];
                        for (NSString *key in values)
                        {
                            NSObject *value = [model valueForKey:key];
                            if (!value)
                            {
                                if ([values[key] isEqualToString:@"BOOL"])
                                {
                                    value = @NO;
                                }
                                else if ([values[key] isEqualToString:@"int"] || [values[key] isEqualToString:@"long"])
                                {
                                    value = @0;
                                }
                                else
                                {
                                    value = @"";
                                }
                            }
                            defaultItem[key] = value;
                        }
                    }
                }
            }
            
            //Add items (can be recursive for sub configs)
            CFLAppConfigOrderedDictionary *loadedConfigs = [CFLAppConfigOrderedDictionary new];
            for (NSDictionary *dictionary in loadedArray)
            {
                if (dictionary[@"name"] && [dictionary[@"name"] length] > 0)
                {
                    [self addStorageItemFromDictionary:loadedConfigs withName:dictionary[@"name"] forObject:dictionary andDefaults:defaultItem];
                }
            }
            return loadedConfigs;
        }
    }
    return nil;
}

- (void)addStorageItemFromDictionary:(CFLAppConfigOrderedDictionary *)loadedConfigs withName:(NSString *)name forObject:(NSDictionary *)object andDefaults:(NSDictionary *)defaultItem
{
    //Insert values
    NSMutableDictionary *addItem = [NSMutableDictionary new];
    if (defaultItem)
    {
        addItem = [defaultItem mutableCopy];
    }
    for (NSString *key in object)
    {
        if (![key isEqualToString:@"subConfigs"])
        {
            addItem[key] = object[key];
        }
    }
    loadedConfigs[name] = addItem;
    
    //Search for sub configs
    NSArray *subConfigs = object[@"subConfigs"];
    if (subConfigs)
    {
        for (NSDictionary *dictionary in subConfigs)
        {
            if (dictionary[@"name"] && [dictionary[@"name"] length] > 0)
            {
                [self addStorageItemFromDictionary:loadedConfigs withName:dictionary[@"name"] forObject:dictionary andDefaults:addItem];
            }
        }
    }
}


#pragma Userdefaults handling

- (void)loadSelectedItemFromUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.selectedItem = [userDefaults valueForKey:kDefaultsSelectedConfigName];
    if (self.selectedItem)
    {
        NSDictionary *values = [userDefaults valueForKey:kDefaultsSelectedConfigDictionary];
        if (values)
        {
            self.storedConfigs[self.selectedItem] = values;
        }
        else
        {
            self.selectedItem = nil;
        }
    }
}

- (void)storeSelectedItemInUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (self.selectedItem && self.storedConfigs[self.selectedItem])
    {
        [userDefaults setValue:self.selectedItem forKey:kDefaultsSelectedConfigName];
        [userDefaults setValue:[self.storedConfigs[self.selectedItem] copy] forKey:kDefaultsSelectedConfigDictionary];
    }
    else
    {
        [userDefaults removeObjectForKey:kDefaultsSelectedConfigName];
        [userDefaults removeObjectForKey:kDefaultsSelectedConfigDictionary];
    }
}


#pragma mark Observers

- (void)addDataObserver:(id)observer selector:(SEL)selector name:(NSString *)identifier
{
    [NSNotificationCenter.defaultCenter addObserver:observer selector:selector name:identifier object:self];
}

- (void)removeDataObserver:(id)observer name:(NSString *)identifier
{
    [NSNotificationCenter.defaultCenter removeObserver:observer name:identifier object:self];
}

@end