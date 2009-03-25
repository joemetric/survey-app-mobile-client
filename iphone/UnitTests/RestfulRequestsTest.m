#import "GTMSenTestCase.h"
#import "RestStubbing.h"
#import "RestfulRequests.h"
#import "RestConfiguration.h"


@interface RestfulRequestsTest : GTMTestCase{
	StubSender *sender;
	StubbedAuthenticationChallenge *challenge;
	NSError *errorFromCallback;
	StubRestDelegate *restDelegate;
	ImplementsNothingStubRestDelegate *implementsNothingRestDelegate;
	StubRestDelegateWithCredentials* restDelegateWithCredentials;
}
RestfulRequests* testee;
@end


@implementation RestfulRequestsTest

-(void)setUp{
	sender = [[StubSender alloc] init];
	challenge = [StubbedAuthenticationChallenge alloc];
	challenge.sender = sender;
	restDelegate = [[StubRestDelegate alloc] init];
	implementsNothingRestDelegate = [[ImplementsNothingStubRestDelegate alloc] init];
	restDelegateWithCredentials = [[StubRestDelegateWithCredentials alloc] init];
	testee = [[Rest alloc] init];
	testee.delegate = restDelegate;
	connectionRequest = nil;
	connectionDelegate = nil;
    testee = [[RestfulRequests restfulRequestsWithDelegate:restDelegate] retain];
}

-(void)tearDown{
	[sender release];
	[challenge release];
	[errorFromCallback release];
	[restDelegate release];
	[implementsNothingRestDelegate release];
	[restDelegateWithCredentials release];
    [testee release];
}

-(void)testGET{
	[testee GET:@"/blah/woot"];	
	STAssertNotNil(connectionRequest, @"connectionRequest");
	STAssertEqualStrings(testee, connectionDelegate, nil);
	
	STAssertEqualStrings(@"GET", [connectionRequest HTTPMethod], @"method");
	STAssertEqualStrings(@"http://localhost:3000/blah/woot", [[connectionRequest URL] absoluteString], @"url");
    
	NSDictionary* headers = [connectionRequest allHTTPHeaderFields];
	STAssertEqualStrings(@"no-cache", [headers valueForKey:@"Cache-Control"], nil);
	STAssertEqualStrings(@"no-cache", [headers valueForKey:@"Pragma"], nil);
	STAssertEqualStrings(@"text/json", [headers valueForKey:@"Accept"], nil);
	STAssertEqualStrings(@"close", [headers valueForKey:@"Connection"], nil);
}


-(void)testAuthenticationFailedCancelsTheChallenge{
	challenge.previousFailureCount=1;
	[testee connection:nil didReceiveAuthenticationChallenge:challenge]; 
	STAssertEqualStrings(challenge, sender->cancelledChallenge, nil);
}

-(void)testUsesRestConfigurationUrlCredentials{
	challenge.previousFailureCount=0;
	[RestConfiguration setUsername:@"marvin"];
	[RestConfiguration setPassword:@"monkeyBoy"];
	[testee connection:nil didReceiveAuthenticationChallenge:challenge]; 
	STAssertEqualStrings(@"marvin", sender->credentialUsed.user, nil);
	STAssertEqualStrings(@"monkeyBoy", sender->credentialUsed.password, nil);
	
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



@end
