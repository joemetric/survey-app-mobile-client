//
//  EditSortSurveyController.m
//  Survey
//
//  Created by Ye Dingding on 09-12-11.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EditSortSurveyController.h"
#import "RestRequest.h"
#import "MiscRestRequest.h"
#import "SurveyAppDelegate.h"
#import "BrowseController.h"
#import "User.h"
#import "Metadata.h"
#import "KVPair.h"


@implementation EditSortSurveyController
@synthesize sortPicker, sortArray;


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
		self.navigationItem.title = @"Sort Survey By";		
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
	
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	User *user = delegate.metadata.user;
	[sortPicker selectRow:([user.sort_id intValue]-1) inComponent:0 animated:NO];
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
	self.sortPicker = nil;
}


- (void)dealloc {
	[sortPicker release]; 
	
    [super dealloc];
}

- (NSMutableArray *)sortArray {
	if (sortArray == nil) {
		NSError *error;
		self.sortArray = [RestRequest getSortArray:&error];
		if (sortArray == nil) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
															message:[error localizedDescription]
														   delegate:self
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
			self.sortArray = [NSMutableArray array];
		}
	}
	return sortArray;
}


- (void)cancel {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	User *user = delegate.metadata.user;
	KVPair *sort = (KVPair *)[self.sortArray objectAtIndex:[sortPicker selectedRowInComponent:0]];
	[user setSort:sort.desc];
	[user setSort_id:sort.pk];
	
	NSError *error;
	BOOL result = [user save:&error];
	if (result) {
		[delegate.browseController setNeedRefresh:TRUE];
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
#pragma mark Sort Picker Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *retval = (UILabel *)view;
	if (!retval) {
		retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 280.0, 44.0)] autorelease];
	}
	
	KVPair *sort = (KVPair *)[self.sortArray objectAtIndex:row];
	retval.text = sort.desc;
	retval.font = [UIFont boldSystemFontOfSize:20];
	retval.backgroundColor = [UIColor clearColor];
	retval.textAlignment = UITextAlignmentCenter;
	
	return retval;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.sortArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}


@end
