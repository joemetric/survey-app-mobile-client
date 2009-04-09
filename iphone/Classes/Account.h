#import "RestfulRequests.h"
#import "AccountObserver.h"

typedef enum {
	accountLoadStatusNotLoaded,
	accountLoadStatusCreatingNew,
	accountLoadStatusLoaded, 
	accountLoadStatusLoadFailed, 
	accountLoadStatusUnauthorized,
	accountLoadStatusFailedValidation} AccountLoadStatus;
	
	

@interface Account : NSObject<RestfulRequestsObserver> {
    NSString *username;
    NSString *password;
    NSString *email;
    NSString *gender;
	NSString* passwordConfirmation;
    NSInteger income;
    NSDate *birthdate;
	NSDictionary* wallet;
	NSError *lastLoadError;
	NSDictionary* errors;
	NSInteger itemId;
    
	NSMutableSet* observers;
    AccountLoadStatus accountLoadStatus;
    
}


+(Account*) currentAccount;
-(void)loadCurrent;
-(void)createNew;
-(void)onChangeNotifyObserver:(id<AccountObserver>)observer;
-(void)noLongerNotifyObserver:(id<AccountObserver>)observer;

@property (nonatomic) NSInteger itemId;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *passwordConfirmation;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSDictionary* wallet;
@property (nonatomic, retain) NSError *lastLoadError;
@property (nonatomic) NSInteger income;
@property (nonatomic, retain) NSDate *birthdate;
@property (nonatomic, readonly) AccountLoadStatus accountLoadStatus;
@property (nonatomic, retain) NSDictionary* errors;
@property (nonatomic, readonly) BOOL isFemale;
@property (nonatomic, readonly) NSDecimalNumber* walletBalance;
@property (nonatomic, readonly) NSInteger walletTransactionCount;
@property(nonatomic, readonly) BOOL isErrorStatus;



@end
