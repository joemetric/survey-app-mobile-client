#import <Foundation/Foundation.h>
#import "RestDelegate.h"

@interface RestfulRequests : NSObject {
    NSObject<RestDelegate>* delegate;
	NSMutableData *buffer;

}

+(id)restfulRequestsWithDelegate:(NSObject<RestDelegate>*)delegate;

@property (nonatomic, assign) NSObject<RestDelegate>* delegate;
- (void)GET:(NSString*) path;

@end
