#import <Foundation/Foundation.h>

@class Rest;

@protocol RestDelegate

@optional
- (void)rest:(Rest *)rest didRetrieveData:(NSData *)data;
- (void)restHasBadCredentials:(Rest *)rest;
- (void)rest:(Rest *)rest didFailWithError:(NSError *)error;
- (void)rest:(Rest *)rest didReceiveStatusCode:(int)statusCode;

@end
