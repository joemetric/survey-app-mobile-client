#import "RestStubbing.h"
#import "GTMSenTestCase.h"


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

@implementation StubRestDelegate

-(void)authenticationFailed{
	authenticationFailed = YES;
}

- (void)rest:(Rest *)rest didFailWithError:(NSError *)error{
	STAssertNotNil(rest, nil);
	errorFromCallback = error;
}

- (void)rest:(Rest *)rest didFinishLoading:(NSString *)data{
	dataFromConnectionFinishedLoading = data;
}

@end


@implementation ImplementsNothingStubRestDelegate
@end

@implementation StubRestDelegateWithCredentials
- (NSURLCredential *)getCredential {
    return [NSURLCredential credentialWithUser:@"rest delegate username"
									  password:@"rest delegate password"
								   persistence:NSURLCredentialPersistenceNone];	
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
