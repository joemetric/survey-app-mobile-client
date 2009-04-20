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
@synthesize credentialsController, newAccountController, noCredentials, validCredentials, noAccountData, loadingAccountData, editProfileDataSource;
@synthesize currentDataSource;


// Correct for navigation bar
-(NSInteger) tableShrinkingKeyboardHeightCorrection{
    return 55;
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
	if (self.isEditing){
		switch([Account currentAccount].accountLoadStatus){
			case accountLoadStatusFailedValidation:
			// Stay editing
			break;
			case accountLoadStatusLoaded:
			self.currentDataSource =  [ValidCredentialsProfileDataSource staticTableForTableView:tableView];			
			((ValidCredentialsProfileDataSource*)currentDataSource).profileViewController = self; // todo - smelly
			[super setEditing:NO animated:YES];
			break;
		}

	}
	else{
		switch([Account currentAccount].accountLoadStatus){
		case accountLoadStatusUnauthorized:
		case accountLoadStatusFailedValidation:
			self.currentDataSource = [NoCredentialsProfileDataSource staticTableForTableView:tableView];
			((NoCredentialsProfileDataSource*)currentDataSource).profileViewController = self; // todo - smelly
			break;
		case accountLoadStatusNotLoaded:
			self.currentDataSource =  [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"Loading account details." andTableView:tableView];
			break;
		case accountLoadStatusLoadFailed:
			self.currentDataSource = [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessage:@"Unable to load account details." andTableView:tableView];	
			break;
		default:
			self.navigationItem.rightBarButtonItem = self.editButtonItem;
			self.currentDataSource =  [ValidCredentialsProfileDataSource staticTableForTableView:tableView];			
			((ValidCredentialsProfileDataSource*)currentDataSource).profileViewController = self; // todo - smelly
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
		self.editProfileDataSource = [EditProfileDataSource editProfileDataSourceWithParentViewController:self andTableView:tableView];
		[super setEditing:editing animated:animated];
	}
    else{
        [self.editProfileDataSource finishedEditing];
    }
	[tableView reloadData];
}

- (void)dealloc {
	[self setEveryObjCObjectPropertyToNil];
	[super dealloc];
}
@end

