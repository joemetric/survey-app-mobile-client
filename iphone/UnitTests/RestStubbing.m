#import "RestStubbing.h"


@implementation StubbedAuthenticationChallenge
@synthesize previousFailureCount, sender;
@end



@implementation StubSender
- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	credentialUsed = credential;
}

- (void)continueWithoutCredentialForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
}

- (void)cancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	cancelledChallenge = challenge;
}
@end




@implementation NSURLConnection(RestStubbing)
+ (NSURLConnection *)connectionWithRequest:(NSURLRequest *)request delegate:(id)delegate{
	connectionRequest = request;
	connectionDelegate = delegate;
	return @"pretend connection";
}

@end


NSURLRequest* connectionRequest ;
id connectionDelegate;
