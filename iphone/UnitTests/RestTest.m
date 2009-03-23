#import "GTMSenTestCase.h"
#import "Rest.h"
#import "RestConfiguration.h"

@interface  StubbedAuthenticationChallenge : NSURLAuthenticationChallenge{
	NSInteger previousFailureCount;
	id<NSURLAuthenticationChallengeSender> sender;
}
@property(nonatomic) NSInteger previousFailureCount;
@property(nonatomic, assign) id<NSURLAuthenticationChallengeSender> sender;
@end

@implementation StubbedAuthenticationChallenge
@synthesize previousFailureCount, sender;


@end


@interface StubSender : NSObject<NSURLAuthenticationChallengeSender>{
@public
	NSURLAuthenticationChallenge* cancelledChallenge;
	NSURLCredential* credentialUsed;
}
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

@interface StubRestDelegate : NSObject<RestDelegate>{
@public
	NSError *errorFromCallback;
	BOOL authenticationFailed;
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

@end

@interface ImplementsNothingStubRestDelegate : NSObject<RestDelegate>
@end

@implementation ImplementsNothingStubRestDelegate
@end

@interface StubRestDelegateWithCredentials  : NSObject<RestDelegate>
@end

@implementation StubRestDelegateWithCredentials
- (NSURLCredential *)getCredential {
    return [NSURLCredential credentialWithUser:@"rest delegate username"
									  password:@"rest delegate password"
								   persistence:NSURLCredentialPersistenceNone];	
}
@end

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


@end
