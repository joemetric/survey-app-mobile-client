#import "GTMSenTestCase.h"
#import "RestStubbing.h"
#import "RestfulRequests.h"
#import "RestConfiguration.h"

@interface StubRestfulRequestsObserver : NSObject<RestfulRequestsObserver>{
@public
	NSError *errorFromCallback;
	BOOL authenticationFailed;
	NSString *dataFromConnectionFinishedLoading;
}
@end

@implementation StubRestfulRequestsObserver
-(void)authenticationFailed{
	authenticationFailed = YES;
}

- (void)failedWithError:(NSError *)error{
	errorFromCallback = error;
}

- (void)finishedLoading:(NSString *)data{
	dataFromConnectionFinishedLoading = data;
}

@end


@interface RestfulRequestsTest : GTMTestCase{
	StubSender *sender;
	StubbedAuthenticationChallenge *challenge;
	NSError *errorFromCallback;
	StubRestfulRequestsObserver *restObserver;
}
RestfulRequests* testee;
@end


@implementation RestfulRequestsTest

-(void)setUp{
	sender = [[StubSender alloc] init];
	challenge = [StubbedAuthenticationChallenge alloc];
	challenge.sender = sender;
	restObserver = [[StubRestfulRequestsObserver alloc] init];
	connectionRequest = nil;
	connectionDelegate = nil;
	testee = [[RestfulRequests restfulRequestsWithObserver:restObserver] retain];
}

-(void)tearDown{
	[sender release];
	[challenge release];
	[errorFromCallback release];
	[restObserver release];
	[testee release];
}

-(void)assertHeaders{
	NSDictionary* headers = [connectionRequest allHTTPHeaderFields];
	STAssertEqualStrings(@"no-cache", [headers valueForKey:@"Cache-Control"], nil);
	STAssertEqualStrings(@"no-cache", [headers valueForKey:@"Pragma"], nil);
	STAssertEqualStrings(@"text/json", [headers valueForKey:@"Accept"], nil);
	STAssertEqualStrings(@"close", [headers valueForKey:@"Connection"], nil);

}

-(void)testGET{
	[testee GET:@"/blah/woot"];	
	STAssertNotNil(connectionRequest, @"connectionRequest");
	STAssertEqualStrings(testee, connectionDelegate, nil);

	STAssertEqualStrings(@"GET", [connectionRequest HTTPMethod], @"method");
	STAssertEqualStrings(@"http://localhost:3000/blah/woot", [[connectionRequest URL] absoluteString], @"url");
	[self assertHeaders];

}

-(void)testPOST{
	NSDictionary* fields = [NSDictionary dictionaryWithObject:@"big" forKey:@"size"];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fields forKey:@"obj"];
	[testee POST:@"/wibble/wobble" withParams:params];	
	STAssertNotNil(connectionRequest, @"connectionRequest");
	STAssertEqualStrings(testee, connectionDelegate, nil);

	STAssertEqualStrings(@"POST", [connectionRequest HTTPMethod], @"method");
	STAssertEqualStrings(@"http://localhost:3000/wibble/wobble", [[connectionRequest URL] absoluteString], @"url");
	[self assertHeaders];
	
	STAssertEqualStrings(@"{\"obj\":{\"size\":\"big\"}}", connectionRequest.HTTPBody, nil);

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
	STAssertTrue(restObserver->authenticationFailed,nil);   
}


-(void)testErrorPassedToDelegate{
	NSError *error = [NSError errorWithDomain:@"test.host" code:NSURLErrorTimedOut userInfo:nil];
	[testee connection:nil didFailWithError:error];
	STAssertEquals(error, restObserver->errorFromCallback, nil);
}




-(void)testDelegateReceivesNotificationWithDataAsStringWhenConnectionFinishesLoading{
	[testee connection:nil didReceiveData:[@"hello " dataUsingEncoding:NSUTF8StringEncoding]];
	[testee connection:nil didReceiveData:[@"matey" dataUsingEncoding:NSUTF8StringEncoding]];
	[testee connectionDidFinishLoading:nil];
	STAssertEqualStrings(@"hello matey", restObserver->dataFromConnectionFinishedLoading, nil);

}

-(void)testNotificationDataResetAfterFinishedLoading{
	[testee connection:nil didReceiveData:[@"hello " dataUsingEncoding:NSUTF8StringEncoding]];
	[testee connectionDidFinishLoading:nil];

	[testee connection:nil didReceiveData:[@"matey" dataUsingEncoding:NSUTF8StringEncoding]];
	[testee connectionDidFinishLoading:nil];
	STAssertEqualStrings(@"matey", restObserver->dataFromConnectionFinishedLoading, nil);

}


@end
