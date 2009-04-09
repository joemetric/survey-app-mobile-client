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

@interface CredentialsViewController : UIViewController<RestDelegate, AccountObserver, UITextFieldDelegate> {
	UIActivityIndicatorView* activityIndicator;
	UITableView* tableView;
	
    StaticTable *staticTable;
	
	LabelledTableViewCell* usernameCell;
	LabelledTableViewCell* passwordCell;
}

- (IBAction) login:(id)sender;
- (IBAction) cancel:(id)sender;


@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) IBOutlet UITableView* tableView;
@end
