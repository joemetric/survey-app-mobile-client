//
//  LoginViewController.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "LoginController.h"
#import "RestRequest.h"
#import "SignupController.h"


@implementation LoginController

@synthesize loginTable, usernameCell, passwordCell, usernameField, passwordField;
@synthesize signupController, isSignUp;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	loginTable.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated {
//	[self performSelectorInBackground:@selector(showBrowseViewController) withObject:nil];
}

- (void)showBrowseViewController {
	if (isSignUp) {
		[self performSelectorOnMainThread:@selector(dismissModalViewControllerAnimated:) withObject:NO waitUntilDone:YES];
	}
	isSignUp = FALSE;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[loginTable release]; self.loginTable = nil;
	[usernameCell release]; self.usernameCell = nil;
	[passwordCell release]; self.passwordCell = nil;
	[usernameField release]; self.usernameField = nil;
	[passwordField release]; self.passwordField = nil;
}


- (void)dealloc {
	[signupController release];
	
    [super dealloc];
}


#pragma mark -
#pragma mark LoginTable Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case 0:
			return usernameCell;
		case 1:
			return passwordCell;
		default:
			break;
	}
	return nil;
}

#pragma mark -
#pragma mark TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return TRUE;
}


- (IBAction)login {
	if ([usernameField.text isEqualToString:@""] || [passwordField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
														message:@"You should fill both login and password"
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	NSError *error;
	BOOL result = [RestRequest loginWithUser:usernameField.text Password:passwordField.text Error:&error];
	if (result) {
		[self dismissModalViewControllerAnimated:YES];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
														message:[error localizedDescription]
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (IBAction)signup {
	if (signupController == nil) {
		SignupController *sc = [[SignupController alloc] initWithNibName:@"SignupView" bundle:nil];
		[sc setLoginController:self];
		self.signupController = sc;
		[sc release];
	}
	[self presentModalViewController:self.signupController animated:YES];
}

@end
