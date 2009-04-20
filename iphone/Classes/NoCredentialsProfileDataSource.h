//
//  NoCredentialsProfileDataSource.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaticTable.h"

@class ProfileViewController;

@interface NoCredentialsProfileDataSource : StaticTable {
	ProfileViewController* profileViewController;
}

+(id)noCredentialsProfileDataSourceForTableView:(UITableView*) tableView profileViewController:(ProfileViewController*)profileViewController;

@property (nonatomic, retain) ProfileViewController* profileViewController;
@end
