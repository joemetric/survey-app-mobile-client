#import <Foundation/Foundation.h>
#import "RestDelegate.h"

@class Rest;
@protocol ResourceDelegate;

@interface Resource : NSObject <RestDelegate> {
    NSInteger itemId;
    NSString *path;
    Rest *rest;
    NSObject<ResourceDelegate>* delegate;
}

@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) Rest *rest;
@property (nonatomic) NSInteger itemId;
@property (nonatomic, assign) id delegate;

+ (id)newFromDictionary:(NSDictionary *) dict;
+ (void) findAllWithDelegate:(id)delegate;
+ (id) createWithParams:(NSDictionary*) parameters;
+ (void) findAllFromRelation:(id) relative withDelegate:(id) delegate;

- (NSDictionary *)toDictionary;

- (id)initWithPath:(NSString *)path;
@end
