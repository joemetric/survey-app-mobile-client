#import "Resource.h"
#import "Rest.h"

@implementation Resource

@synthesize itemId;

+ (id)newFromDictionary:(NSDictionary *) dict
{
    NSLog(@"I need to implement newFromDictionary:");
    return nil;
}

- (NSDictionary *)toDictionary
{
    NSLog(@"I need to implement toDictionary");
    return nil;
}

+ (NSString *)resourceName
{
    NSLog(@"I need to implement +resourceName");
    return @"";
}

+ (NSString *)resourceKey
{
    NSLog(@"I need to implement +resourceKey");
    return @"";
}

+ (NSArray *) findAll
{
    NSString       *path = [NSString stringWithFormat:@"/%@.json", [self resourceName]];
    Rest           *rest = [[Rest alloc] initWithHost:@"foo:bar@localhost" atPort:3000];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    id              item;
    
    NSArray *item_dicts = [rest GET:path];
    for (id dict in item_dicts) {
        item = [self newFromDictionary:dict];
        [items addObject:item];
        [item release];
    }

    [rest release];
    return [items autorelease];
}

+ (id) findAllFromRelation:(id) relative
{
    NSString *path = [NSString stringWithFormat:@"/%@/%d/%@.json", [[relative class] resourceName], [relative itemId], [self resourceName]];
    Rest           *rest = [[Rest alloc] initWithHost:@"foo:bar@localhost" atPort:3000];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    id              item;
    
    NSArray *item_dicts = [rest GET:path];
    for (id dict in item_dicts) {
        item = [self newFromDictionary:dict];
        [items addObject:item];
        [item release];
    }

    [rest release];
    return [items autorelease];
}

// SHOW - GET
+ (id) findWithId:(NSInteger) item_id
{
    NSString *path = [NSString stringWithFormat:@"/%@/%d.json", [self resourceName], item_id];
    Rest *rest      = [[Rest alloc] initWithHost:@"foo:bar@localhost" atPort:3000];

    NSDictionary *item_dict = [rest GET:path];
    [rest release];

    if (item_dict == nil) {
        return nil;
    }

    id item = [self newFromDictionary:item_dict];

    return [item autorelease];
}

// CREATE - POST
+ (id) createWithParams:(NSDictionary *)parameters
{
    
    NSString *path = [NSString stringWithFormat:@"/%@.json", [self resourceName]];
    Rest     *rest = [[Rest alloc] initWithHost:@"foo:bar@localhost" atPort:3000];
    id item;

    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:[self resourceKey]];
    
    NSDictionary *item_dict = [rest POST:path withParameters:container];
    [rest release];

    [container release];
    
    if (item_dict == nil) {
        return nil;
    }
    
    item = [self newFromDictionary:item_dict];

    return [item autorelease];
}

// DELETE - DELETE
+ (BOOL) deleteWithId:(NSInteger) item_id
{
    NSString *path = [NSString stringWithFormat:@"/%@/%d.json", [self resourceName], item_id];
    Rest     *rest = [[Rest alloc] initWithHost:@"foo:bar@localhost" atPort:3000];

    BOOL results = [rest DELETE:path];

    [rest release];

    return results;
}

// UPDATE - PUT
- (BOOL) update
{
    NSString *path = [NSString stringWithFormat:@"/%@/%d.json", [[self class] resourceName], self.itemId];
    Rest     *rest = [[Rest alloc] initWithHost:@"foo:bar@localhost" atPort:3000];

    BOOL results = [rest PUT:path withParameters:[self toDictionary]];
    
    [rest release];

    return results;
}

@end
