#import "RestfulRequests.h"
#import "RestConfiguration.h"

@implementation RestfulRequests
@synthesize delegate;

+(id)restfulRequestsWithDelegate:(id<RestDelegate>)delegate{
	RestfulRequests* result = [[[RestfulRequests alloc] init] autorelease];
	result.delegate = delegate;
	return result;
}

-(id)init{
	[super init];
	buffer = [[NSMutableData alloc] init];
	return self;
}

-(void)dealloc{
	[buffer release];
	self.delegate = nil;
	[super dealloc];
}

- (void)GET:(NSString*) path{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d%@", [RestConfiguration host], [RestConfiguration port], path]];

	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    [req addValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [req addValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
    [req addValue:@"text/json" forHTTPHeaderField:@"Accept"];
    [req addValue:@"close" forHTTPHeaderField:@"Connection"];
    
    
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
		if ([delegate respondsToSelector:@selector(authenticationFailed)]) [delegate authenticationFailed];
	}else{
		if ([delegate respondsToSelector:@selector(rest:didFailWithError:)]) [delegate rest:self didFailWithError:error];
	}
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[buffer appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if ([delegate respondsToSelector:@selector(rest:didFinishLoading:)]){
		NSString *strbuffer = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
		[self.delegate rest:self didFinishLoading:strbuffer];
	}
	[buffer setLength:0];
}



@end
