//
//  ProfileViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CredentialsViewController;
@class NewAccountViewController;
@class NoCredentialsProfileDataSource;
@class ValidCredentialsProfileDataSource;

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView* tableView;
	CredentialsViewController* credentialsController;
	NewAccountViewController* newAccountController;
	NoCredentialsProfileDataSource* noCredentials;
	ValidCredentialsProfileDataSource* validCredentials;
}

//- (IBAction)createAccount:(id)sender;
//- (IBAction)saveAccount:(id)sender;
- (void) displayModalCredentialsController;


@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) CredentialsViewController* credentialsController;
@property (nonatomic, retain) NewAccountViewController* newAccountController;
@property (nonatomic, retain) NoCredentialsProfileDataSource* noCredentials;
@property (nonatomic, retain) ValidCredentialsProfileDataSource* validCredentials;

@end
