#import "GTMSenTestCase.h"
#import "Rest.h"
#import "RestConfiguration.h"
#import "RestStubbing.h"

@interface RestTest:GTMTestCase{
	Rest *testee;
	StubSender *sender;
	StubbedAuthenticationChallenge *challenge;
	NSError *errorFromCallback;
	BOOL authenticationFailed;
	StubRestDelegate *restDelegate;
	ImplementsNothingStubRestDelegate *implementsNothingRestDelegate;
	StubRestDelegateWithCredentials* restDelegateWithCredentials;
}
@end



@implementation RestTest
-(void)setUp{
	sender = [[StubSender alloc] init];
	challenge = [StubbedAuthenticationChallenge alloc];
	challenge.sender = sender;
	authenticationFailed = NO;
	restDelegate = [[StubRestDelegate alloc] init];
	implementsNothingRestDelegate = [[ImplementsNothingStubRestDelegate alloc] init];
	restDelegateWithCredentials = [[StubRestDelegateWithCredentials alloc] init];
	testee = [[Rest alloc] init];
	testee.delegate = restDelegate;
	connectionRequest = nil;
	connectionDelegate = nil;
}

-(void)tearDown{
	[restDelegate release];
	[implementsNothingRestDelegate release];
	[sender release];
	[challenge release];
	[restDelegateWithCredentials release];
	[testee release];
}
-(void)testAuthenticationFailedCancelsTheChallenge{
	challenge.previousFailureCount=1;
	[testee connection:nil didReceiveAuthenticationChallenge:challenge]; 
	STAssertEqualStrings(challenge, sender->cancelledChallenge, nil);
}

-(void)testAuthenticationFailedErrorPassedToDelegate{
	NSError *error = [NSError errorWithDomain:@"test.host" code:NSURLErrorUserCancelledAuthentication userInfo:nil];
	[testee connection:nil didFailWithError:error];
	STAssertTrue(restDelegate->authenticationFailed,nil);   
}

-(void)testAuthenticationFailedOnDelegatIsOptional{
	testee.delegate = implementsNothingRestDelegate;
	NSError *error = [NSError errorWithDomain:@"test.host" code:NSURLErrorUserCancelledAuthentication userInfo:nil];
	[testee connection:nil didFailWithError:error];	
}


-(void)testErrorPassedToDelegate{
	NSError *error = [NSError errorWithDomain:@"test.host" code:NSURLErrorTimedOut userInfo:nil];
	[testee connection:nil didFailWithError:error];
	STAssertEquals(error, restDelegate->errorFromCallback, nil);
}

-(void)testRestFailedWithErrorOnDelegateIsOptional{
	testee.delegate = implementsNothingRestDelegate;
	NSError *error = [NSError errorWithDomain:@"test.host" code:NSURLErrorTimedOut userInfo:nil];
	[testee connection:nil didFailWithError:error];

}

-(void) testUsesRestConfigurationUrlCredentialsByDefault{
	[RestConfiguration setUsername:@"marvin"];
	[RestConfiguration setPassword:@"monkeyBoy"];
	[testee connection:nil didReceiveAuthenticationChallenge:challenge]; 
	STAssertEqualStrings(@"marvin", sender->credentialUsed.user, nil);
	STAssertEqualStrings(@"monkeyBoy", sender->credentialUsed.password, nil);
	
}

-(void) testUsesDelegateCredentialsIfProvided{
	testee.delegate = restDelegateWithCredentials;
	[testee connection:nil didReceiveAuthenticationChallenge:challenge]; 
	STAssertEqualStrings(@"rest delegate username", sender->credentialUsed.user, nil);
	STAssertEqualStrings(@"rest delegate password", sender->credentialUsed.password, nil);
}

-(void)testDelegateReceivesNotificationWithDataAsStringWhenConnectionFinishesLoading{
    [testee connection:nil didReceiveData:[@"hello " dataUsingEncoding:NSUTF8StringEncoding]];
    [testee connection:nil didReceiveData:[@"matey" dataUsingEncoding:NSUTF8StringEncoding]];
	[testee connectionDidFinishLoading:nil];
	STAssertEqualStrings(@"hello matey", restDelegate->dataFromConnectionFinishedLoading, nil);
    
}

-(void)testNotificationDataResetAfterFinishedLoading{
    [testee connection:nil didReceiveData:[@"hello " dataUsingEncoding:NSUTF8StringEncoding]];
	[testee connectionDidFinishLoading:nil];

    [testee connection:nil didReceiveData:[@"matey" dataUsingEncoding:NSUTF8StringEncoding]];
	[testee connectionDidFinishLoading:nil];
	STAssertEqualStrings(@"matey", restDelegate->dataFromConnectionFinishedLoading, nil);
	
}

-(void)testRestDidFinishLoadingOnDelegateIsOptional{
	testee.delegate = implementsNothingRestDelegate;
	[testee connectionDidFinishLoading:nil];	
}

-(void)xtestGET{
	[testee GET:@"/blah/woot"];	
	STAssertNotNil(connectionRequest, @"connectionRequest");
	// STAssertEqualStrings(testee, connectionDelegate, nil);
	
	STAssertEqualStrings(@"GET", [connectionRequest HTTPMethod], @"method");
	STAssertEqualStrings(@"http://localhost:3000/blah/woot", [[connectionRequest URL] absoluteString], @"url");

	NSDictionary* headers = [connectionRequest allHTTPHeaderFields];
	STAssertEqualStrings(@"no-cache", [headers valueForKey:@"Cache-Control"], nil);
	STAssertEqualStrings(@"no-cache", [headers valueForKey:@"Pragma"], nil);
	STAssertEqualStrings(@"text/json", [headers valueForKey:@"Accept"], nil);
	STAssertEqualStrings(@"close", [headers valueForKey:@"Connection"], nil);
}


@end



