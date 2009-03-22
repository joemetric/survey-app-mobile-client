#import <Foundation/Foundation.h>
#import "RestDelegate.h"

@interface Rest : NSObject {
    NSString *host;
    NSInteger port;
    NSURLConnection *conn;
    NSMutableURLRequest *request;
    NSObject<RestDelegate> *delegate;
    SEL action;
}

@property (nonatomic, retain) NSString *host;
@property (nonatomic) NSInteger port;

@property (nonatomic, assign) NSObject<RestDelegate> *delegate;



- (void)GET:(NSString*) path withCallback:(SEL)callback;
- (NSDictionary *)POST:(NSString *)path withParameters:(NSDictionary *)parameters;
- (BOOL)PUT:(NSString *)path withParameters:(NSDictionary *)parameters;
- (BOOL)DELETE:(NSString *)path;

@end
