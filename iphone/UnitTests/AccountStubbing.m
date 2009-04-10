#import "AccountStubbing.h"

Account *gAccount;

@implementation Account(AccountStubbing)

+(Account*) currentAccount{
    return gAccount;
}

-(void)setAccountLoadStatus:(AccountLoadStatus)_status{
    accountLoadStatus = _status;
}

-(BOOL)isObserver:(id<AccountObserver>)observer{
	return [observers containsObject:observer];
}

@end