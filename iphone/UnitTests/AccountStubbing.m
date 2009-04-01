#import "AccountStubbing.h"

Account *gAccount;

@implementation Account(AccountStubbing)

+(Account*) currentAccount{
    return gAccount;
}

-(void)setAccountLoadStatus:(AccountLoadStatus)_status{
    accountLoadStatus = _status;
}

@end