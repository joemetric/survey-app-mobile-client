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
- (NSObject<UITableViewDelegate, UITableViewDataSource>*) tableDelegate;
@end

@implementation ProfileViewController
@synthesize tableView, credentialsController, newAccountController, noCredentials, validCredentials, noAccountData;
@synthesize accountSectionHeader, demographicsSectionHeader;

-(void)changeInAccount:(Account*) _account{
    /* TODO - REPLACE THIS HACK WITH SOME POLYMORPHISM OR SOMETHING */
    if (self.modalViewController == self.newAccountController){
		[newAccountController accountChanged];
    }
    /* END HACK*/
        
    
	if (accountLoadStatusLoaded == [Account currentAccount].accountLoadStatus){
		[self dismissModalViewControllerAnimated:YES];
	}
	[self.tableView reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {

	self.noCredentials = [[[NoCredentialsProfileDataSource alloc] init] autorelease];
	self.noCredentials.profileViewController = self;

	self.validCredentials = [[[ValidCredentialsProfileDataSource alloc] init] autorelease];
	self.validCredentials.profileViewController = self;
	self.validCredentials.account = [Account currentAccount];
	self.noAccountData = [[[NoAccountDataProfileDataSource alloc] init] autorelease];
	[[Account currentAccount] onChangeNotifyObserver:self];
    self.tableView.backgroundColor = [UIColor clearColor];
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
		self.credentialsController.profileView = self;
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
		self.noAccountData.message = @"Loading account details.";
		return self.noAccountData;	
		case accountLoadStatusLoadFailed:
		self.noAccountData.message = @"Unable to load account details.";
		return self.noAccountData;
		default:
		return self.validCredentials;
	}
}



#pragma mark -
#pragma mark TableViewDelegate and DataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
	return [[self tableDelegate] numberOfSectionsInTableView:tv];
}

- (NSString*)tableView:(UITableView*) tv titleForHeaderInSection:(NSInteger) section {
	return [[self tableDelegate] tableView:tv titleForHeaderInSection:section];
}

- (NSString*)tableView:(UITableView*) tv titleForFooterInSection:(NSInteger) section {
	return [[self tableDelegate] tableView:tv titleForFooterInSection:section];
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [[self tableDelegate] tableView:tv numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [[self tableDelegate] tableView:tv cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[[self tableDelegate] tableView:tv didSelectRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}



- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)section{
	return [[self tableDelegate] tableView:tv viewForHeaderInSection:section];
}




- (void)dealloc {
	[tableView release];
	[credentialsController release];
	[noAccountData release];
	[noCredentials release];
	[validCredentials release];
	[newAccountController release];
	[demographicsSectionHeader release];
	[accountSectionHeader release];
	[super dealloc];
}
@end

