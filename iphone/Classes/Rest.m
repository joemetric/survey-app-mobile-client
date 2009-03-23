#import "Rest.h"
#import "JSON.h"
#import "RestConfiguration.h"

@implementation Rest

@synthesize host;
@synthesize port;
@synthesize delegate;

- (void)cancelConnection
{
	[conn cancel];
	[conn release];
	conn = nil;
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if ([delegate respondsToSelector:@selector(rest:didFinishLoading:)]){
        NSString *strbuffer = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
		[self.delegate rest:self didFinishLoading:strbuffer];
	}
	[buffer setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	NSLog(@"Rest#connection:DidReceiveData:");
	[buffer appendData:data];
	[self.delegate performSelector:action withObject:data];
}

-(NSURLCredential*) getCredential{
	return [RestConfiguration urlCredential];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge previousFailureCount] > 0) {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
	}
	else{
		id credentialSource = self;
		if([delegate respondsToSelector:@selector(getCredential)]) credentialSource = delegate;
		[[challenge sender] useCredential:[credentialSource getCredential] forAuthenticationChallenge:challenge];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	if ([error code] == NSURLErrorUserCancelledAuthentication){
		if ([delegate respondsToSelector:@selector(authenticationFailed)]) [delegate authenticationFailed];
	}else{
		if ([delegate respondsToSelector:@selector(rest:didFailWithError:)]) [delegate rest:self didFailWithError:error];
	}
}



- (void)startConnection:(NSURLRequest *)aRequest
{
	[self cancelConnection];
	conn = [[NSURLConnection alloc] initWithRequest:aRequest
		delegate:self
		startImmediately:YES];
	if (!conn) {
		if ([delegate respondsToSelector:@selector(rest:didFailWithError:)]) {
			NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObject:[aRequest URL] forKey:NSErrorFailingURLStringKey];
			[info setObject:@"Could not open connection" forKey:NSLocalizedDescriptionKey];
			NSError *error = [NSError errorWithDomain:@"Rest" code:1 userInfo:info];
			[delegate rest:self didFailWithError:error];
		}
	}
}



- (NSString *)hostString
{
	return [NSString stringWithFormat:@"%@:%d", self.host, self.port];
}

- (void)GET:(NSString *)path withCallback:(SEL)callback
{
	NSURL         *url = [[NSURL alloc] initWithScheme:@"http" host:[self hostString] path:path];
	action = callback;

	NSLog(@"GET: %@", url);

	[request setHTTPMethod:@"GET"];
	[request setURL:url];

	[self startConnection:request];

	[url release];
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

	// STODO
	data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];

	[url release];

	dataStr  = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSLog(@"ds: %@", dataStr);
	if ([(NSHTTPURLResponse*)response statusCode] != 200) {
		NSLog(@"FAILURE HERE: %@", dataStr);
		[dataStr release];
		return nil;
	}

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

	// STODO
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

	// STODO
	[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];

	[url release];
	return [(NSHTTPURLResponse*)response statusCode] == 200;
}

-(id) init{
	[super init];

	host = [RestConfiguration host];
	port = [RestConfiguration port];

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

	buffer = [[NSMutableData alloc] init];

	return self;
}


- (void)dealloc{
	self.delegate = nil;
	[buffer release];
	[host release];
	[request release];
	[super dealloc];
}
@end
