#import "Resource.h"
#import "ResourceDelegate.h"
#import "Rest.h"
#import "JSON.h"
#import "JoeMetricAppDelegate.h"

@implementation Resource

@synthesize itemId;
@synthesize rest;
@synthesize path;
@synthesize delegate;

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

- (void) findAllReceived:(NSData *)data
{
    NSString      *dataStr;
    NSArray       *item_dicts;

    dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    item_dicts = [dataStr JSONFragmentValue];
    [dataStr release];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    id              item;
    
    for (id dict in item_dicts) {
        item = [[self class] newFromDictionary:dict];
        [items addObject:item];
        [item release];
    }

    [delegate resource:self itemsReceived:items];
    [items autorelease];
}

+ (void) findAllWithDelegate:(id)delegate
{
    Resource *resource = [[self alloc] initWithPath:[NSString stringWithFormat:@"/%@.json",
                                                                  [self resourceName]]];
    resource.delegate = delegate;

    [resource.rest GET:resource.path withCallback:@selector(findAllReceived:)];
}


- (void)findAllFromRelationReceived:(NSData *)data
{
    NSString *dataStr;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    id              item;
    NSArray *item_dicts;

    dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    item_dicts = [dataStr JSONFragmentValue];
    [dataStr release];
    
    for (id dict in item_dicts) {
        item = [[self class] newFromDictionary:dict];
        [items addObject:item];
        [item release];
    }

    [delegate resource:self itemsReceived:items];
    [items autorelease];
}

+ (void) findAllFromRelation:(id) relative withDelegate:(id)delegate
{
    Resource *resource = [[self alloc] initWithPath:[NSString stringWithFormat:@"/%@/%d/%@.json",
                                                                  [[relative class] resourceName],
                                                                  [relative itemId],
                                                                  [self resourceName]]];
    resource.delegate = delegate;

    [resource.rest GET:resource.path withCallback:@selector(findAllFromRelationReceived:)];
}

// CREATE - POST
// STODO - asychronize
+ (id) createWithParams:(NSDictionary *)parameters
{
    Resource *resource = [[Resource alloc] initWithPath:[NSString stringWithFormat:@"/%@.json", [self resourceName]]];

    id item;

    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:[self resourceKey]];
    
    NSDictionary *item_dict = [resource.rest POST:resource.path withParameters:container];
    [resource release];

    [container release];
    
    if (item_dict == nil) {
        return nil;
    }
    
    item = [self newFromDictionary:item_dict];

    return [item autorelease];
}

- (NSURLCredential *)getCredentials
{
    return [(JoeMetricAppDelegate*)[UIApplication sharedApplication].delegate getCredentials];
}

- (void)authenticationFailed
{
    [(JoeMetricAppDelegate*)[UIApplication sharedApplication].delegate authenticationFailed];
}

- (id)initWithPath:(NSString *)aPath
{
    if (self = [super init]) {
        self.path = aPath;
        self.rest = [[Rest alloc] init];
        self.rest.delegate = self;
    }

    return self;
}

- (void)dealloc
{
    [path release];
    [rest release];
    [super dealloc];
}

@end
