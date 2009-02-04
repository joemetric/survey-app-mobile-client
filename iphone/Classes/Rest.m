#import "Rest.h"
#import "JSON.h"

@implementation Rest

@synthesize host;
@synthesize port;
@synthesize delegate;

- (NSString *)hostString
{
    return [NSString stringWithFormat:@"%@:%d", self.host, self.port];
}

- (id)GET:(NSString *)path
{
    NSURL         *url = [[NSURL alloc] initWithScheme:@"http" host:[self hostString] path:path];
    NSURLResponse *response;
    NSData        *data;
    NSString      *dataStr;
    id             fragment; // Could be an NSDictionary, NSArray, or other type

    NSLog(@"GET: %@", url);

    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    
    data     = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];

    [url release];

    if ([(NSHTTPURLResponse*)response statusCode] != 200) {
        return nil;
    }

    dataStr  = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    fragment = [dataStr JSONFragmentValue];

    [dataStr release];
    
    return fragment;
}

- (NSDictionary *)POST:(NSString *)path withParameters:(NSDictionary *)parameters
{
    NSURL         *url = [[NSURL alloc] initWithScheme:@"http" host:[self hostString] path:path];
    NSURLResponse *response;
    NSData        *data;
    NSString      *dataStr;
    NSDictionary  *fragment;
    
    NSLog(@"POST: %@", url);
    
    [request setHTTPMethod:@"POST"];
    [request setURL:url];

    if (parameters != nil) {
        NSString *params = [parameters JSONRepresentation];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];

    [url release];

    if ([(NSHTTPURLResponse*)response statusCode] != 200) {
        return nil;
    }
    
    dataStr  = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    fragment = [dataStr JSONFragmentValue];

    [dataStr release];
    
    return fragment;
}

- (BOOL)PUT:(NSString *)path withParameters:(NSDictionary *)parameters
{
    NSURL         *url = [[NSURL alloc] initWithScheme:@"http" host:[self hostString] path:path];
    NSURLResponse *response;

    NSLog(@"PUT: %@", url);

    [request setHTTPMethod:@"PUT"];
    [request setURL:url];
    
    if (parameters != nil) {
        NSString *params = [parameters JSONRepresentation];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    }

    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];

    [url release];
    return [(NSHTTPURLResponse*)response statusCode] == 200;
}

- (BOOL)DELETE:(NSString *)path
{
    NSURL         *url = [[NSURL alloc] initWithScheme:@"http" host:[self hostString] path:path];
    NSURLResponse *response;

    NSLog(@"DELETE: %@", url);

    [request setHTTPMethod:@"DELETE"];
    [request setURL:url];

    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];

    [url release];
    return [(NSHTTPURLResponse*)response statusCode] == 200;
}

- (id)initWithHost:(NSString *)hostName atPort:(NSInteger)portNumber
{
    if (self = [super init]) {
        host = [hostName copy];
        port = portNumber;

        NSMutableDictionary* headers = [[[NSMutableDictionary alloc] init] autorelease];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:@"text/json" forKey:@"Accept"];
        [headers setValue:@"no-cache" forKey:@"Cache-Control"];
        [headers setValue:@"no-cache" forKey:@"Pragma"];
        [headers setValue:@"close" forKey:@"Connection"]; // Avoid HTTP 1.1 "keep alive" for the connection
        
        request = [NSMutableURLRequest requestWithURL:nil
                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:60.0];
        [request retain];
        [request setAllHTTPHeaderFields:headers];
    }
    
    return self;
}

- (void)dealloc
{
    [host release];
    [request release];
    [super dealloc];
}
@end
