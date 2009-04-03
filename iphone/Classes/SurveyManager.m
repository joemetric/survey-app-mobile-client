#import "SurveyManager.h"
#import "RestConfiguration.h"
#import "JSON.h"

@implementation SurveyManager

@synthesize observer;

- (void)cancelConnection {
    [conn cancel];
    [conn release];
    conn = nil;
}

- (void)startConnection:(NSURLRequest *)aRequest {
    [self cancelConnection];
    conn = [[NSURLConnection alloc] initWithRequest:aRequest delegate:self startImmediately:YES];
    if (!conn) {
        NSLog(@"Survey load connection failed");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *dataStr;
    NSArray *surveys;
    
    dataStr = [[NSString alloc] initWithData:buffer encoding:NSASCIIStringEncoding];
    
    surveys = [dataStr JSONFragmentValue];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *surveyDirectory = [documentsDirectory stringByAppendingPathComponent:@"surveys"];
    
    // Ensure surveys directory exists
    [[NSFileManager defaultManager] createDirectoryAtPath:surveyDirectory attributes:nil];
    
    // Write one plist file per survey, surveys/n.plist
    // Can do 'sync' by checking updated_at from the plist
    for (id survey in surveys) {
        NSString *surveyFilePath = [surveyDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", 
                                                                                    [survey objectForKey:@"id"]]];
        [survey writeToFile:surveyFilePath atomically:YES];
    }

    [dataStr release];
    
    [observer surveysStored];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection error: %@", error);
}


- (BOOL)loadSurveysFromNetwork {
    // connection to app, download, write plist
    NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:[NSString stringWithFormat:@"%@:%d", host, port] path:@"/surveys.json"];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];

    [self startConnection:request];
    
    [url release];
    
    return YES;
}

+ (NSArray *)loadSurveysFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *surveyDirectory = [documentsDirectory stringByAppendingPathComponent:@"surveys"];
    NSMutableArray *surveys = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id surveyFile in [[NSFileManager defaultManager] directoryContentsAtPath:surveyDirectory]) {
        [surveys addObject:[NSDictionary dictionaryWithContentsOfFile:[surveyDirectory stringByAppendingPathComponent:surveyFile]]];
    }
    
    return [surveys autorelease];
}

- (id)init {
    return [self initWithObserver:nil];
}

- (id)initWithObserver:(NSObject<SurveyManagerObserver> *)delegate {
    if (self = [super init]) {
        host   = [RestConfiguration host];
        port   = [RestConfiguration port];
        buffer = [[NSMutableData alloc] init];
        
        NSMutableDictionary *headers = [[[NSMutableDictionary alloc] init] autorelease];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:@"text/json" forKey:@"Accept"];
        [headers setValue:@"no-cache" forKey:@"Cache-Control"];
        [headers setValue:@"no-cache" forKey:@"Pragma"];
        [headers setValue:@"close" forKey:@"Connection"];
        
        request = [NSMutableURLRequest requestWithURL:nil
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                      timeoutInterval:60.0];
        
        [request setAllHTTPHeaderFields:headers];
        
        self.observer = delegate;
    }
    return self;
}

- (void)dealloc {
    [buffer release];
    [super dealloc];
}
@end
