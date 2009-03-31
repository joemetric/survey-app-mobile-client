#import "RestfulRequests.h"
#import "RestConfiguration.h"
#import "JSON.h"

@implementation RestfulRequests
@synthesize observer;

+(id)restfulRequestsWithObserver:(NSObject<RestfulRequestsObserver>*)observer{
	RestfulRequests* result = [[[RestfulRequests alloc] init] autorelease];
	result.observer = observer;
	return result;
}

-(id)init{
	[super init];
	buffer = [[NSMutableData alloc] init];
	return self;
}

-(void)dealloc{
	[buffer release];
	self.observer = nil;
	[super dealloc];
}

-(NSMutableURLRequest*)jsonRequestWithHttpMethod:(NSString*)httpMethod andPath:(NSString*) path{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d%@", [RestConfiguration host], [RestConfiguration port], path]];

	NSMutableURLRequest* result = [NSMutableURLRequest requestWithURL:url];
	result.HTTPMethod = httpMethod;
    [result addValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [result addValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
    [result addValue:@"text/json" forHTTPHeaderField:@"Accept"];
    [result addValue:@"close" forHTTPHeaderField:@"Connection"];
	[result addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	return result;
}

- (void)GET:(NSString*) path{
	NSMutableURLRequest *req = [self jsonRequestWithHttpMethod:@"GET" andPath:path];    
 	[NSURLConnection connectionWithRequest:req delegate:self];
} 


-(void)POST:(NSString*) path withParams:(NSDictionary*)params{
	NSMutableURLRequest *req = [self jsonRequestWithHttpMethod:@"POST" andPath:path];    
	req.HTTPBody = [[params JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
	[NSURLConnection connectionWithRequest:req delegate:self];
}



- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge previousFailureCount] > 0) {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
	}
	else{
		[[challenge sender] useCredential:[RestConfiguration urlCredential] forAuthenticationChallenge:challenge];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	if ([error code] == NSURLErrorUserCancelledAuthentication){
		[observer authenticationFailed];
	}else{
		[observer failedWithError:error];
	}
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[buffer appendData:data];
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[buffer setLength:0];	
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *strbuffer = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
	[self.observer finishedLoading:strbuffer];
	[buffer setLength:0];
}



@end
