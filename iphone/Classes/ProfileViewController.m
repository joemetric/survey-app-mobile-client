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
#import "ValidCredentialsProfileDataSource.h"
#import "CredentialsViewController.h"
#import "NewAccountViewController.h"
#import "Account.h"
#import "Rest.h"

@interface ProfileViewController (Private)
- (BOOL) hasValidCredentials;
- (NSObject<UITableViewDelegate, UITableViewDataSource>*) tableDelegate;
@end

@implementation ProfileViewController
@synthesize tableView, credentialsController, newAccountController, noCredentials, validCredentials, account;


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	NSLog(@"viewDidLoad!!!");
    
    
	self.noCredentials = [[[NoCredentialsProfileDataSource alloc] init] autorelease];
	self.noCredentials.profileViewController = self;
	
	self.validCredentials = [[[ValidCredentialsProfileDataSource alloc] init] autorelease];
	self.validCredentials.profileViewController = self;
    

    NSLog(@"APPEAR");
    self.account = [Account currentAccount];
    NSLog(@"Account: %@", account);
	
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
	if( self.newAccountController == nil ) {
		self.newAccountController = [[[NewAccountViewController alloc] initWithNibName:@"NewAccountView" bundle:nil] autorelease];
		self.newAccountController.profileView = self;
	}
	[self presentModalViewController:self.newAccountController animated:YES];
}

- (BOOL) hasValidCredentials {
	return ![[[NSUserDefaults standardUserDefaults] stringForKey:@"username"] isEqualToString:(@"")];
}

- (NSObject<UITableViewDelegate, UITableViewDataSource>*) tableDelegate {
	if( [self hasValidCredentials] == YES )
		return self.validCredentials;
	else
		return self.noCredentials;
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




- (void)dealloc {
	[tableView release];
	[credentialsController release];
    [account release];
    [super dealloc];
}

//- (IBAction)createAccount:(id)sender
//{
//    NSLog(@"Creating with: %@ : %@", [usernameField text], [passwordField text]);
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    if (usernameField.text) {
//        [params setObject:[usernameField text] forKey:@"login"];
//    } else {
//        [params setObject:@"" forKey:@"login"];
//    }
//
//    if (emailField.text) {
//        [params setObject:emailField.text forKey:@"email"];
//    } else {
//        [params setObject:@"" forKey:@"email"];
//    }
//
//    if (passwordField.text) {
//        [params setObject:[passwordField text] forKey:@"password"];
//        [params setObject:[passwordField text] forKey:@"password_confirmation"];
//    } else {
//        [params setObject:@"" forKey:@"password"];
//        [params setObject:@"" forKey:@"password_confirmation"];
//    }
//
//    Account *account = [Account createWithParams:params];
//    if (account) {
//        [self saveAccount:sender];
//    } else {
//        // Pop up an alert or something?
//        NSLog(@"Account creation hath FAILED");
//    }
//    
//    [params release];
//}
//
//- (IBAction)saveAccount:(id)sender
//{
//    NSMutableDictionary *credentials = [[NSMutableDictionary alloc] initWithCapacity: 2];
//    [credentials setObject:[usernameField text] forKey:@"username"];
//    [credentials setObject:[passwordField text] forKey:@"password"];
//
//
//    JoeMetricAppDelegate *appDelegate = (JoeMetricAppDelegate*)[[UIApplication sharedApplication] delegate];
//    appDelegate.credentials = credentials;
//    [appDelegate saveCredentials];
//}
@end

