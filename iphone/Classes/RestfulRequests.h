#import <Foundation/Foundation.h>
#import "RestDelegate.h"

@protocol RestfulRequestsObserver
-(void) authenticationFailed; 
-(void) failedWithError:(NSError *)error;
-(void) finishedLoading:(NSString *)data;
@end

@interface RestfulRequests : NSObject {
    NSObject<RestfulRequestsObserver>* observer;
	NSMutableData *buffer;

}

+(id)restfulRequestsWithObserver:(NSObject<RestfulRequestsObserver>*)delegate;

@property (nonatomic, retain) NSObject<RestfulRequestsObserver>* observer;

-(void)GET:(NSString*) path;
-(void)POST:(NSString*) path withParams:(NSDictionary*)params;
-(void)PUT:(NSString*) path withParams:(NSDictionary*)params;
@end
