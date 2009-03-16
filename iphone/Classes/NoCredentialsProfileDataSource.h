//
//  NoCredentialsProfileDataSource.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProfileViewController;

@interface NoCredentialsProfileDataSource : NSObject <UITableViewDataSource, UITableViewDelegate> {
	ProfileViewController* profileViewController;
}

@property (nonatomic, retain) ProfileViewController* profileViewController;
@end
