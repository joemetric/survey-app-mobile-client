//
//  EditIncomingController.m
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "EditRaceController.h"
#import "SurveyAppDelegate.h"
#import "Metadata.h"
#import "User.h"
#import "KVPair.h"
#import "MiscRestRequest.h"


@implementation EditRaceController
@synthesize racePicker, raceArray;


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
		self.navigationItem.title = @"Edit Race";		
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
	self.racePicker = nil;
}


- (void)dealloc {
	[racePicker release]; 
	
    [super dealloc];
}

- (NSMutableArray *)raceArray {
	if (raceArray == nil) {
		NSError *error;
		self.raceArray = [RestRequest getRaceArray:&error];
		if (raceArray == nil) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
															message:[error localizedDescription]
														   delegate:self
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
			self.raceArray = [NSMutableArray array];
		}
	}
	return raceArray;
}


- (void)cancel {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	User *user = delegate.metadata.user;
	KVPair *race = (KVPair *)[self.raceArray objectAtIndex:[racePicker selectedRowInComponent:0]];
	[user setRace:race.desc];
	[user setRace_id:race.pk];
	
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


#pragma mark -
#pragma mark Income Picker Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *retval = (UILabel *)view;
	if (!retval) {
		retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 280.0, 44.0)] autorelease];
	}
	
	KVPair *race = (KVPair *)[self.raceArray objectAtIndex:row];
	retval.text = race.desc;
	retval.font = [UIFont boldSystemFontOfSize:16];
	retval.backgroundColor = [UIColor clearColor];
	retval.textAlignment = UITextAlignmentCenter;
	
	return retval;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.raceArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}


@end
