//
//  ProfileViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "JoeMetricAppDelegate.h"
#import "ProfileViewController.h"
#import "CredentialsViewController.h"
#import "Account.h"

@implementation ProfileViewController
@synthesize tableView, credentialsController;


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString*)tableView:(UITableView*) tv titleForHeaderInSection:(NSInteger) section {
	return @"Account";
}

- (NSString*)tableView:(UITableView*) tv titleForFooterInSection:(NSInteger) section {
	return @"\n\nWe don't seem to have any account details\n\nPlease login to your account\nif you have one, or create a new account.";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if( indexPath.row == 0 )
		cell.text = @"Login";
	else
		cell.text = @"Signup";
    return cell;
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
	//do stuff
	[super dismissModalViewControllerAnimated:animated];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"SELECT");
	if( indexPath.row == 0 ) {
		//push modal controller for user/pass
		if( self.credentialsController == nil ) {
			self.credentialsController = [[[CredentialsViewController alloc] initWithNibName:@"CredentialsView" bundle:nil] autorelease];
			self.credentialsController.profileView = self;
		}
		[self presentModalViewController:self.credentialsController animated:YES];
	} else if( indexPath.row == 1 ) {
		//push modal controller for create account
	} 
}


- (void)dealloc {
	[tableView release];
	[credentialsController release];
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

