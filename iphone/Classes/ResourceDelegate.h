#import <Foundation/Foundation.h>

@class Resource;

@protocol ResourceDelegate

@optional
- (void)resource:(Resource*) resource itemsReceived:(NSArray *)items;
@end
