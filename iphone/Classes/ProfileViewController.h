//
//  ProfileViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CredentialsViewController;

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView* tableView;
	CredentialsViewController* credentialsController;
}

//- (IBAction)createAccount:(id)sender;
//- (IBAction)saveAccount:(id)sender;

@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) CredentialsViewController* credentialsController;

@end
