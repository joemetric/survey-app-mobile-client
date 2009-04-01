#import "Resource.h"
#import "RestfulRequests.h"

typedef enum {
	accountLoadStatusNotLoaded,
	accountLoadStatusLoaded, 
	accountLoadStatusLoadFailed, 
	accountLoadStatusUnauthorized,
	accountLoadStatusFailedValidation} AccountLoadStatus;

@interface Account : Resource<RestfulRequestsObserver> {
    NSString *username;
    NSString *password;
    NSString *email;
    NSString *gender;
	NSString* passwordConfirmation;
    NSInteger income;
    NSDate *birthdate;
	NSError *lastLoadError;
	NSDictionary* errors;
    
    id callbackObject;
    SEL callbackSelector; 
    AccountLoadStatus accountLoadStatus;
    
}


+(Account*) currentAccount;
-(void)populateFromReceivedData:(NSData *)data;
-(void)onChangeNotify:(SEL)callme on:(id)callMeObj;
-(void)loadCurrent;
-(void)createNew;
-(BOOL)hasErrors;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *passwordConfirmation;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSError *lastLoadError;
@property (nonatomic) NSInteger income;
@property (nonatomic, retain) NSDate *birthdate;
@property(nonatomic, readonly) AccountLoadStatus accountLoadStatus;
@property (nonatomic, retain) NSDictionary* errors;



@end
