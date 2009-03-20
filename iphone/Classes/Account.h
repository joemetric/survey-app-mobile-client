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
    
    id callMeBackOnLoadDelegate;
    SEL callMeBackOnLoadSelector; 
    AccountLoadStatus accountLoadStatus;
    
}


+(Account*) currentAccountWithCallback:(SEL)callme on:(id)delegate;
- (void)populateFromReceivedData:(NSData *)data;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic) NSInteger income;
@property (nonatomic, retain) NSDate *birthdate;
@property(nonatomic, readonly) AccountLoadStatus accountLoadStatus;




@end
