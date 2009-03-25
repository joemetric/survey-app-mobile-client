#import "RestDelegate.h"

@interface  StubbedAuthenticationChallenge : NSURLAuthenticationChallenge{
	NSInteger previousFailureCount;
	id<NSURLAuthenticationChallengeSender> sender;
}
@property(nonatomic) NSInteger previousFailureCount;
@property(nonatomic, assign) id<NSURLAuthenticationChallengeSender> sender;
@end

@interface StubSender : NSObject<NSURLAuthenticationChallengeSender>{
@public
	NSURLAuthenticationChallenge* cancelledChallenge;
	NSURLCredential* credentialUsed;
}
@end

@interface StubRestDelegate : NSObject<RestDelegate>{
@public
	NSError *errorFromCallback;
	BOOL authenticationFailed;
    NSString *dataFromConnectionFinishedLoading;
}
@end

@interface ImplementsNothingStubRestDelegate : NSObject<RestDelegate>
@end

@interface StubRestDelegateWithCredentials  : NSObject<RestDelegate>
@end

@interface NSURLConnection(RestStubbing)
+ (NSURLConnection *)connectionWithRequest:(NSURLRequest *)request delegate:(id)delegate;

@end

extern NSURLRequest* connectionRequest ;
extern id connectionDelegate;



