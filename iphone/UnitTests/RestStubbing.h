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


@interface NSURLConnection(RestStubbing)
+ (NSURLConnection *)connectionWithRequest:(NSURLRequest *)request delegate:(id)delegate;

@end

extern NSURLRequest* connectionRequest ;
extern id connectionDelegate;



