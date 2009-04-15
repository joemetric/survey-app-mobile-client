//
//  ProfileViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "JoeMetricAppDelegate.h"
#import "ProfileViewController.h"
#import "NoCredentialsProfileDataSource.h"
#import "NoAccountDataProfileDataSource.h"
#import "ValidCredentialsProfileDataSource.h"
#import "CredentialsViewController.h"
#import "NewAccountViewController.h"

@interface ProfileViewController (Private)
- (void) setTableDelegate;
@end

@implementation ProfileViewController
@synthesize tableView, credentialsController, newAccountController, noCredentials, validCredentials, 
    noAccountData, loadingAccountData;



-(void)changeInAccount:(Account*) _account{
	if (accountLoadStatusLoaded == [Account currentAccount].accountLoadStatus){
		[self dismissModalViewControllerAnimated:YES];
	}
    [self setTableDelegate];
	[self.tableView reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {

	self.noCredentials = [[[NoCredentialsProfileDataSource alloc] init] autorelease];
	self.noCredentials.profileViewController = self;

	self.validCredentials = [[[ValidCredentialsProfileDataSource alloc] init] autorelease];
	self.validCredentials.profileViewController = self;
	self.noAccountData = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"Unable to load account details." andTableView:tableView];
	self.loadingAccountData = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"Loading account details." andTableView:tableView];
	[[Account currentAccount] onChangeNotifyObserver:self];
    [self setTableDelegate];
	[super viewDidLoad];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
	[self.tableView reloadData];
	[super dismissModalViewControllerAnimated:animated];
}

- (void) displayModalCredentialsController {
	if( self.credentialsController == nil ) {
		self.credentialsController = [[[CredentialsViewController alloc] initWithNibName:@"CredentialsView" bundle:nil] autorelease];
	}
	[self presentModalViewController:self.credentialsController animated:YES];
}

- (void) displayModalNewAccountController {
	[self dismissModalViewControllerAnimated:YES];
	if( self.newAccountController == nil ) {
		self.newAccountController = [[[NewAccountViewController alloc] initWithNibName:@"NewAccountView" bundle:nil] autorelease];
		self.newAccountController.profileView = self;
	}
	[self presentModalViewController:self.newAccountController animated:YES];
}

- (NSObject<UITableViewDelegate, UITableViewDataSource>*) tableDelegate {
	switch([Account currentAccount].accountLoadStatus){
	case accountLoadStatusUnauthorized:
	case accountLoadStatusFailedValidation:
		return self.noCredentials;
	case accountLoadStatusNotLoaded:
		return loadingAccountData;
	case accountLoadStatusLoadFailed:
		return noAccountData;	
	default:
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
		return self.validCredentials;
	}
}

- (void) setTableDelegate{
    NSObject<UITableViewDelegate, UITableViewDataSource>* delegate = [self tableDelegate];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
}

- (void)dealloc {
	[tableView release];
	[credentialsController release];
	[noAccountData release];
	[loadingAccountData release];
	[noCredentials release];
	[validCredentials release];
	[newAccountController release];
	[super dealloc];
}
@end

