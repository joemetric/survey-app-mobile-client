//
//  SignupController.m
//  Survey
//
//  Created by Allerin on 09-10-2.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "SignupController.h"
#import "RestRequest.h"
#import "LoginController.h"


@implementation SignupController

@synthesize signupTable;
@synthesize loginCell, nameCell, emailCell, passwordCell, passwordConfirmationCell;
@synthesize loginField, nameField, emailField, passwordField, passwordConfirmationField;
@synthesize loginController;

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
	
	self.signupTable.backgroundColor = [UIColor clearColor];
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
	self.signupTable = nil;
	self.loginCell = nil;
	self.nameCell = nil;
	self.emailCell = nil;
	self.passwordCell = nil;
	self.passwordConfirmationCell = nil;
	self.loginField = nil;
	self.nameField = nil;
	self.emailField = nil;
	self.passwordField = nil;
	self.passwordConfirmationField = nil;
}


- (void)dealloc {
	[signupTable release]; 
	[loginCell release]; 
	[nameCell release]; 
	[emailCell release]; 
	[passwordCell release]; 
	[passwordConfirmationCell release]; 
	[loginField release]; 
	[nameField release]; 
	[emailField release]; 
	[passwordField release]; 
	[passwordConfirmationField release]; 
	
    [super dealloc];
}

#pragma mark -
#pragma mark LoginTable Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case 0:
			return loginCell;
		case 1:
			return nameCell;
		case 2:
			return emailCell;
		case 3:
			return passwordCell;
		case 4:
			return passwordConfirmationCell;
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


- (IBAction)cancel {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)done {
	if ([nameField.text isEqualToString:@""] || [loginField.text isEqualToString:@""] || 
		[emailField.text isEqualToString:@""] || [passwordField.text isEqualToString:@""] || [passwordConfirmationField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
														message:@"You must fill all the fields"
													   delegate:self
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	if (![passwordField.text isEqualToString:passwordConfirmationField.text]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
														message:@"Confirmation password not match"
													   delegate:self
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	NSError *error;
	BOOL result = [RestRequest signUpWithUser:loginField.text Password:passwordField.text Email:emailField.text Name:nameField.text Error:&error];
	if (result) {
		[self.loginController setIsSignUp:TRUE];
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

@end
