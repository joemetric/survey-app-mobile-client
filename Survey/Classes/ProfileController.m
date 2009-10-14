//
//  ProfileViewController.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "ProfileController.h"
#import "SurveyAppDelegate.h"
#import "Model.h"


@implementation ProfileController

@synthesize profileTable, emailCell, birthdayCell, genderCell, zipcodeCell, incomeCell;
@synthesize emailLabel, birthdayLabel, genderLabel, zipcodeLabel, incomeLabel;

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[profileTable reloadData];
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
	[profileTable release]; self.profileTable = nil;
	[emailCell release]; self.emailCell = nil;
	[birthdayCell release]; self.birthdayCell = nil;
	[genderCell release]; self.genderCell = nil;
	[zipcodeCell release]; self.zipcodeCell = nil;
	[incomeCell release]; self.incomeCell = nil;
	[emailLabel release]; self.emailLabel = nil;
	[birthdayLabel release]; self.birthdayLabel = nil;
	[genderLabel release]; self.genderLabel = nil;
	[zipcodeLabel release]; self.zipcodeLabel = nil;
	[incomeLabel release]; self.incomeLabel = nil;
}


- (void)dealloc {
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
	SurveyAppDelegate *delegate = (SurveyAppDelegate *)[[UIApplication sharedApplication] delegate];
	User *user = delegate.metadata.user;								
	switch (indexPath.row) {
		case 0:
			emailLabel.text = user.email;
			return emailCell;
		case 1:
			birthdayLabel.text = [user birthdate];
			return birthdayCell;
		case 2:
			genderLabel.text = user.gender;
			return genderCell;
		case 3:
			// zipcodeLabel.text = @"";
			return zipcodeCell;
		case 4:
			incomeLabel.text = user.income;
			return incomeCell;
		default:
			break;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
