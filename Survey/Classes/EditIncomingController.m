//
//  EditIncomingController.m
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "EditIncomingController.h"
#import "SurveyAppDelegate.h"
#import "Metadata.h"
#import "User.h"


@implementation EditIncomingController
@synthesize incomingField;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
		self.navigationItem.leftBarButtonItem = cancelButton;
		[cancelButton release];
		UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
		self.navigationItem.rightBarButtonItem = saveButton;
		[saveButton release];
		self.navigationItem.title = @"Edit Incoming";		
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[incomingField becomeFirstResponder];
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
	[incomingField release]; self.incomingField = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (void)cancel {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	User *user = delegate.metadata.user;
	[user setIncome:incomingField.text];
	
	NSError *error;
	BOOL result = [user save:&error];
	if (result) {
		[self cancel];
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
