#import "Account.h"

extern Account *gAccount;
@interface Account(AccountStubbing)
+(Account*) currentAccount;
-(void)setAccountLoadStatus:(AccountLoadStatus)loadStatus;
@end

