#import "GTMSenTestCase.h"
#import "Rest.h"

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
}
@end

@implementation StubSender
- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
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

@interface ImplementsNothingStubRestDelegate : NSObject
@end

@implementation ImplementsNothingStubRestDelegate
@end


@interface RestTest:GTMTestCase{
    Rest *testee;
    StubSender *sender;
    StubbedAuthenticationChallenge *challenge;
	NSError *errorFromCallback;
	BOOL authenticationFailed;
	StubRestDelegate *restDelegate;
	ImplementsNothingStubRestDelegate *implementsNothingRestDelegate;
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
    testee = [[Rest alloc] init];
    testee.delegate = restDelegate;
}

-(void)tearDown{
	[restDelegate release];
	[implementsNothingRestDelegate release];
    [sender release];
    [challenge release];
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

-(void)testRestFailedWithDerorOnDelegateIsOptional{
	testee.delegate = implementsNothingRestDelegate;
	NSError *error = [NSError errorWithDomain:@"test.host" code:NSURLErrorTimedOut userInfo:nil];
    [testee connection:nil didFailWithError:error];
	
}



@end
