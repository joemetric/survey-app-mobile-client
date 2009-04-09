//
//  CredentialsViewController.h
//  JoeMetric
//
//  Created by Alan Francis on 13/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestDelegate.h"
#import "AccountObserver.h"

@class ProfileViewController;
@class StaticTable;
@class LabelledTableViewCell;

@interface CredentialsViewController : UIViewController<RestDelegate, AccountObserver> {
	UITextField* username;
	UITextField* password;
	UIActivityIndicatorView* activityIndicator;
	UILabel* errorLabel;
	UITableView* tableView;
	
	ProfileViewController* profileView;
    StaticTable *staticTable;
	
	LabelledTableViewCell* usernameCell;
	LabelledTableViewCell* passwordCell;
}

- (IBAction) login:(id)sender;
- (IBAction) cancel:(id)sender;

@property (nonatomic, retain) ProfileViewController* profileView;

@property (nonatomic, retain) IBOutlet UITextField* username;
@property (nonatomic, retain) IBOutlet UITextField* password;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) IBOutlet UILabel* errorLabel;
@property (nonatomic, retain) IBOutlet UITableView* tableView;
@end
