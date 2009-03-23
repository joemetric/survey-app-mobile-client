#import <Foundation/Foundation.h>

@class Rest;

@protocol RestDelegate

@optional
- (void)rest:(Rest *)rest didRetrieveData:(NSData *)data;
- (void)rest:(Rest *)rest didFailWithError:(NSError *)error;
- (void)rest:(Rest *)rest didReceiveStatusCode:(int)statusCode;
- (void)rest:(Rest *)rest finishedLoading:(NSString *)data;

/* Out of step with the other method sigs.  Passing the rest object is more idiomatic Cocoa, but
   isn't actually useful.  Can't decided whether to change these sigs, or the others.
*/
- (void)authenticationFailed; 
- (NSURLCredential *) getCredential;

@end
