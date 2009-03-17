//
//  ValidCredentialsProfileDataSource.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProfileViewController;
@class Account;

@interface ValidCredentialsProfileDataSource : NSObject <UITableViewDataSource, UITableViewDelegate> {
	ProfileViewController* profileViewController;
    Account *account;
}

@property (nonatomic, retain) ProfileViewController* profileViewController;
@property (nonatomic, retain) Account *account;
@end
