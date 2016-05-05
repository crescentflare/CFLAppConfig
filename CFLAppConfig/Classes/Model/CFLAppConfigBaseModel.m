//
//  CFLAppConfigBaseModel.m
//  CFLAppConfig Pod
//

//Imports
#import "CFLAppConfigBaseModel.h"
#import "CFLAppConfigEnumSerializer.h"
#import "objc/runtime.h"

//Internal interface definition
@interface CFLAppConfigBaseModel ()
@end

//Interface implementation
@implementation CFLAppConfigBaseModel

#pragma mark NSObject

- (id)init
{
    self = [super init];
    if (self)
    {
        [self resetToDefaults];
    }
    return self;
}


#pragma mark Implementation

+ (NSDictionary *)modelStructure
{
    return nil;
}

+ (NSDictionary *)modelStructureField:(NSString *)fieldName
{
    NSDictionary *modelStructure = [self.class modelStructure];
    if (modelStructure)
    {
        if (modelStructure[@"categories"])
        {
            for (NSDictionary *category in modelStructure[@"categories"])
            {
                if (category[@"fields"])
                {
                    for (NSDictionary *field in category[@"fields"])
                    {
                        if (field[@"fieldName"] && [field[@"fieldName"] isEqualToString:fieldName])
                        {
                            return field;
                        }
                    }
                }
            }
        }
        if (modelStructure[@"fields"])
        {
            for (NSDictionary *field in modelStructure[@"fields"])
            {
                if (field[@"fieldName"] && [field[@"fieldName"] isEqualToString:fieldName])
                {
                    return field;
                }
            }
        }
    }
    return nil;
}

- (NSDictionary *)obtainValueTypes
{
    NSDictionary *supportedTypes = @{
                                     @"c": @"BOOL",
                                     @"i": @"int",
                                     @"l": @"long",
                                     @"@\"NSString\"": @"NSString"
                                     };
    NSMutableDictionary *valueTypes = [NSMutableDictionary new];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++)
    {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *propertyType = [NSString stringWithUTF8String:property_getAttributes(properties[i])];
        NSArray *typeList = [propertyType componentsSeparatedByString:@","];
        for (NSString *type in typeList)
        {
            if ([[type substringToIndex:1] isEqualToString:@"T"])
            {
                NSString *convertedType = supportedTypes[[type substringFromIndex:1]];
                if (!convertedType)
                {
                    convertedType = @"Unknown";
                }
                [valueTypes setObject:convertedType forKey:propertyName];
                break;
            }
        }
    }
    free(properties);
    return valueTypes;
}

- (void)applyOverrides:(NSDictionary *)overrides withName:(NSString *)name
{
    NSDictionary *valueTypes = [self obtainValueTypes];
    NSDictionary *structure = [self.class modelStructure];
    for (NSString *key in valueTypes)
    {
        if ([key isEqualToString:@"name"])
        {
            if (name)
            {
                [self setValue:name forKey:key];
            }
        }
        else if (overrides[key])
        {
            if (structure)
            {
                NSDictionary *field = [self findFieldInModelStructure:structure forName:key];
                if (field)
                {
                    if ([overrides[key] isKindOfClass:NSString.class] && field[@"customSerializer"])
                    {
                        NSObject *customSerializer = field[@"customSerializer"];
                        if ([customSerializer isKindOfClass:CFLAppConfigEnumSerializer.class])
                        {
                            CFLAppConfigEnumSerializer *enumSerializer = (CFLAppConfigEnumSerializer *)customSerializer;
                            NSInteger enumValue = [enumSerializer.class fromStringValue:(NSString *)overrides[key]];
                            [self setValue:@(enumValue) forKey:key];
                            continue;
                        }
                    }
                }
            }
            [self setValue:overrides[key] forKey:key];
        }
    }
}


#pragma mark Internal model structure search

- (NSDictionary *)findFieldInModelStructureArray:(NSArray *)fieldArray forName:(NSString *)fieldName
{
    for (NSDictionary *field in fieldArray)
    {
        if (field[@"fieldName"] && [field[@"fieldName"] isEqualToString:fieldName])
        {
            return field;
        }
    }
    return nil;
}

- (NSDictionary *)findFieldInModelStructure:(NSDictionary *)structure forName:(NSString *)fieldName
{
    if (structure[@"fields"] && [structure[@"fields"] isKindOfClass:[NSArray class]])
    {
        NSDictionary *foundField = [self findFieldInModelStructureArray:structure[@"fields"] forName:fieldName];
        if (foundField)
        {
            return foundField;
        }
    }
    if (structure[@"categories"] && [structure[@"categories"] isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *category in structure[@"categories"])
        {
            if (category[@"fields"] && [category[@"fields"] isKindOfClass:[NSArray class]])
            {
                NSDictionary *foundField = [self findFieldInModelStructureArray:category[@"fields"] forName:fieldName];
                if (foundField)
                {
                    return foundField;
                }
            }
        }
    }
    return nil;
}


#pragma mark Internal others

- (void)resetToDefaults
{
    NSDictionary *structure = [self.class modelStructure];
    if (structure)
    {
        NSDictionary *valueTypes = [self obtainValueTypes];
        for (NSString *key in valueTypes)
        {
            NSDictionary *field = [self findFieldInModelStructure:structure forName:key];
            if (field)
            {
                if (field[@"defaultValue"])
                {
                    [self setValue:field[@"defaultValue"] forKey:key];
                }
            }
        }
    }
}

@end