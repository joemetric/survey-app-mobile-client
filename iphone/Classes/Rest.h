#import <Foundation/Foundation.h>

@interface Rest : NSObject {
    NSString *host;
    NSInteger port;
    NSMutableURLRequest *request;
    id delegate;
}

@property (nonatomic, retain) NSString *host;
@property (nonatomic) NSInteger port;

@property (nonatomic, assign) id delegate;

- (id)initWithHost:(NSString *)host atPort:(NSInteger)port;

- (id)GET:(NSString*) path;
- (NSDictionary *)POST:(NSString *)path withParameters:(NSDictionary *)parameters;
- (BOOL)PUT:(NSString *)path withParameters:(NSDictionary *)parameters;
- (BOOL)DELETE:(NSString *)path;
@end
