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

@class Account;

@interface ValidCredentialsProfileDataSource : StaticTable<AccountObserver> {
    Account *account;
	NSNumberFormatter *numberFormatter;
	NSDateFormatter *dateFormatter;
}

@end
