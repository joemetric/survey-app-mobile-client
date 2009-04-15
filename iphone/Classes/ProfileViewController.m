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
@synthesize tableView;
@synthesize credentialsController, newAccountController, noCredentials, validCredentials, noAccountData, loadingAccountData;



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


- (void) setTableDelegate{
	switch([Account currentAccount].accountLoadStatus){
        case accountLoadStatusUnauthorized:
        case accountLoadStatusFailedValidation:
            [self.noCredentials beDelegateAndDataSourceForThisTableView:self.tableView];
            break;
        case accountLoadStatusNotLoaded:
            [self.loadingAccountData beDelegateAndDataSourceForThisTableView:self.tableView];
            break;
        case accountLoadStatusLoadFailed:
            [self.noAccountData beDelegateAndDataSourceForThisTableView:self.tableView];	
			break;
        default:
            self.navigationItem.rightBarButtonItem = self.editButtonItem;
            [self.validCredentials beDelegateAndDataSourceForThisTableView:self.tableView];
            break;
	}
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    NSLog(@"setEditing:%d animated:%d", editing, animated);
    self.editButtonItem.enabled = NO;
    [super setEditing:editing animated:animated];
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

