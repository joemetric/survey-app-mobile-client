#import <Foundation/Foundation.h>
#import "RestDelegate.h"

@interface RestfulRequests : NSObject {
    id<RestDelegate> delegate;
	NSMutableData *buffer;

}

+(id)restfulRequestsWithDelegate:(id<RestDelegate>)delegate;

@property (nonatomic, assign) id<RestDelegate> delegate;
- (void)GET:(NSString*) path;

@end
