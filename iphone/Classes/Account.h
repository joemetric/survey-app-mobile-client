//
//  Account.h
//  JoeMetric
//
//  Created by Scott Barron on 12/22/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//
#import "Resource.h"
typedef enum {accountLoadStatusNotLoaded, accountLoadStatusLoaded, accountLoadStatusLoadFailed, accountLoadStatusUnauthorized} AccountLoadStatus;

@interface Account : Resource {
    NSString *username;
    NSString *password;
    NSString *email;
    NSString *gender;
    NSInteger income;
    NSDate *birthdate;
	NSError *lastLoadError;
    
    id callMeBackOnLoadDelegate;
    SEL callMeBackOnLoadSelector; 
    AccountLoadStatus accountLoadStatus;
    
}


+(Account*) currentAccount;
- (void)populateFromReceivedData:(NSData *)data;
-(void)onChangeNotify:(SEL)callme on:(id)callMeObj;
-(void)loadCurrent;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSError *lastLoadError;
@property (nonatomic) NSInteger income;
@property (nonatomic, retain) NSDate *birthdate;
@property(nonatomic, readonly) AccountLoadStatus accountLoadStatus;




@end
