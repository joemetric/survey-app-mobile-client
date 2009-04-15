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
#import "NSObject+CleanUpProperties.h"
#import "EditProfileDataSource.h"

@interface ProfileViewController (Private)
- (void) setTableDelegate;
@end

@implementation ProfileViewController
@synthesize tableView;
@synthesize credentialsController, newAccountController, noCredentials, validCredentials, noAccountData, loadingAccountData, editProfileDataSource;




// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {

	self.noCredentials = [[[NoCredentialsProfileDataSource alloc] init] autorelease];
	self.noCredentials.profileViewController = self;

	self.validCredentials = [[[ValidCredentialsProfileDataSource alloc] init] autorelease];
	self.validCredentials.profileViewController = self;
	self.noAccountData = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"Unable to load account details." andTableView:tableView];
	self.loadingAccountData = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"Loading account details." andTableView:tableView];
	self.editProfileDataSource = [EditProfileDataSource staticTableForTableView:nil];
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
	if (self.isEditing){
		switch([Account currentAccount].accountLoadStatus){
			case accountLoadStatusFailedValidation:
			// Stay editing
			break;
			case accountLoadStatusLoaded:
			[self.validCredentials beDelegateAndDataSourceForThisTableView:self.tableView];
			[super setEditing:NO animated:YES];
			break;
		}

	}
	else{
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
}

-(void)changeInAccount:(Account*) _account{
	if (accountLoadStatusLoaded == [Account currentAccount].accountLoadStatus){
		[self dismissModalViewControllerAnimated:YES];
	}

    [self setTableDelegate];
	[self.tableView reloadData];
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
	if(editing){
		[self.editProfileDataSource beDelegateAndDataSourceForThisTableView:self.tableView];
		[super setEditing:editing animated:animated];
	}
    else{
        [[Account currentAccount] update];
    }
	[tableView reloadData];
}

- (void)dealloc {
	[self setEveryObjCObjectPropertyToNil];
	[super dealloc];
}
@end

