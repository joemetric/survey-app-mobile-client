//
//  SettingsController.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//
#import "PercentageToDonateController.h"

#import "SettingsController.h"
#import "SurveyAppDelegate.h"
#import "Metadata.h"
#import "User.h"
#import "EditSortSurveyController.h"

@implementation SettingsController
@synthesize settingsTable;
@synthesize newSurveyAlertCell, locationSpecificSurveyCell, sortSurveyCell, locationCell;
@synthesize newSurveyAlertSwitch, locatonSpecificSurveySwitch, sortSurveyLabel;
@synthesize editSortSurveyController,sliderBottonOn;
@synthesize additionalCharityContributionCell,selectedPercentage,percentageToDonateController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void) awakeFromNib {
	UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.tiff"]];
	[iv setFrame:CGRectMake(0, 0, 27, 44)];
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:iv];
	self.navigationItem.leftBarButtonItem = leftButton;
	[leftButton release];
	[iv release];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

- (void) selectedPercentageToDonate: (NSNotification*) notification{
	selectedPercentage.textColor = [UIColor whiteColor];
	selectedPercentage.text = notification.object;//percentages;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	selectedPercentage.text = @"0%";
	selectedPercentage.textColor = [UIColor whiteColor];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedPercentageToDonate:)
												 name:@"selectedPercentageToDonate" object:nil];

	}

- (void)viewWillAppear:(BOOL)animated {
	[settingsTable reloadData];
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
	self.settingsTable = nil;
	self.newSurveyAlertCell = nil;
	self.locationSpecificSurveyCell = nil;
	self.sortSurveyCell = nil;
	self.locationCell = nil;
	self.newSurveyAlertSwitch = nil;
	self.sortSurveyLabel = nil;
	self.locatonSpecificSurveySwitch = nil;
	self.editSortSurveyController = nil;
	self.additionalCharityContributionCell = nil;
	self.selectedPercentage = nil;
	self.percentageToDonateController = nil;
}


- (void)dealloc {
	[settingsTable release]; 
	[newSurveyAlertCell release]; 
	[locationSpecificSurveyCell release]; 
	[sortSurveyCell release]; 
	[locationCell release];  
	[newSurveyAlertSwitch release]; 
	[sortSurveyLabel release]; 
	[locatonSpecificSurveySwitch release]; 
	[editSortSurveyController release];
	[additionalCharityContributionCell release];
	[selectedPercentage release];
	[percentageToDonateController release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


#pragma mark -
#pragma mark LoginTable Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 2)
		return 174;
	else
		return 44;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {							
	[settingsTable deselectRowAtIndexPath:indexPath animated:NO];

	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	User *user = delegate.metadata.user;
	switch (indexPath.row) {
		case 0:
			sortSurveyLabel.text = user.sort;
			return sortSurveyCell;
			//			return newSurveyAlertCell;
		case 1:
			return locationSpecificSurveyCell;
		case 2:
			return additionalCharityContributionCell;
			//		case 3:
			//			return locationCell;
		default:
			break;
	}
	return nil;
}

#pragma mark -
#pragma mark bring XIBs

- (IBAction)goToSortSurveyController:(id)sender {
	self.sliderBottonOn = YES;
	[self.navigationController pushViewController:self.editSortSurveyController animated:YES];
}

- (EditSortSurveyController *)editSortSurveyController {
	if (editSortSurveyController == nil) {
		EditSortSurveyController *essc = [[EditSortSurveyController alloc] initWithNibName:@"EditSortView" bundle:nil];
		self.editSortSurveyController = essc;
		[essc release];
	}
	return editSortSurveyController;
}

- (IBAction) goToSelectPercentageSlider:(id) sender {
	[self.navigationController pushViewController:self.percentageToDonateController animated:YES];
}

- (PercentageToDonateController *)percentageToDonateController {
	if (percentageToDonateController == nil) {
		PercentageToDonateController *ptdc = [[PercentageToDonateController alloc] initWithNibName:@"PercentageToDonateController" bundle:nil];
		self.percentageToDonateController = ptdc;
		sliderBottonOn = YES;

		[ptdc release];
	}
	return percentageToDonateController;
}


@end
