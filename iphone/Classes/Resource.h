#import <Foundation/Foundation.h>

@interface Resource : NSObject {
    NSInteger itemId;
}

@property (nonatomic) NSInteger itemId;

+ (id)newFromDictionary:(NSDictionary *) dict;
+ (NSArray *) findAll;
+ (id) findWithId:(NSInteger) item_id;
+ (id) createWithParams:(NSDictionary*) parameters;
+ (BOOL) deleteWithId:(NSInteger) item_id;

- (BOOL)update;
- (NSDictionary *)toDictionary;

@end
