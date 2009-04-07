//
//  ValidCredentialsProfileDataSource.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaticTable.h"
#import "AccountObserver.h"

@class ProfileViewController;
@class Account;

@interface ValidCredentialsProfileDataSource : StaticTable {
	ProfileViewController* profileViewController;
    Account *account;
	NSNumberFormatter *numberFormatter;
	NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) ProfileViewController* profileViewController;
@end
