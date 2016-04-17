//
//  CFLAppConfigOrderedDictionary.m
//  CFLAppConfig Pod
//

//Import
#import "CFLAppConfigOrderedDictionary.h"

//Internal interface definition
@interface CFLAppConfigOrderedDictionary ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSMutableArray *array;

@end

//Interface implementation
@implementation CFLAppConfigOrderedDictionary

- (id)init
{
    self = [super init];
    if (self)
    {
        self.dictionary = [NSMutableDictionary new];
        self.array = [NSMutableArray new];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity
{
    self = [super initWithCapacity:capacity];
    if (self)
    {
        self.dictionary = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        self.array = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    if (![self.dictionary objectForKey:aKey])
    {
        [self.array addObject:aKey];
    }
    [self.dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey
{
    [self.dictionary removeObjectForKey:aKey];
    [self.array removeObject:aKey];
}

- (NSUInteger)count
{
    return [self.dictionary count];
}

- (id)objectForKey:(id)aKey
{
    return [self.dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
    return [self.array objectEnumerator];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])stackbuf count:(NSUInteger)len
{
    return [self.array countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (NSDictionary *)objectForKeyedSubscript:(id)aKey
{
    return [self objectForKey:aKey];
}

- (void)setObject:(NSDictionary *)anObject forKeyedSubscript:(id)aKey
{
    [self setObject:anObject forKey:aKey];
}

@end
