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
#import "EditBirthdayController.h"
#import "EditGenderController.h"
#import "EditIncomingController.h"
#import "EditZipcodeController.h"
#import "EditRaceController.h"
#import "EditMartialController.h"
#import "EditEducationController.h"
#import "EditOccupationController.h"


@implementation ProfileController

@synthesize profileTable, emailCell, birthdayCell, genderCell, zipcodeCell, incomeCell;
@synthesize raceCell, martialCell, educationCell, occupationCell;
@synthesize emailLabel, birthdayLabel, genderLabel, zipcodeLabel, incomeLabel;
@synthesize raceLabel, martialLabel, educationLabel, occupationLabel;
@synthesize editBirthdayController, editGenderController, editIncomingController, editZipcodeController;
@synthesize editRaceController, editMartialController, editEducationController, editOccupationController;

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
	self.profileTable = nil;
	self.emailCell = nil;
	self.birthdayCell = nil;
	self.genderCell = nil;
	self.zipcodeCell = nil;
	self.incomeCell = nil;
	self.raceCell = nil;
	self.martialCell = nil;
	self.educationCell = nil;
	self.occupationCell = nil;
	self.emailLabel = nil;
	self.birthdayLabel = nil;
	self.genderLabel = nil;
	self.zipcodeLabel = nil;
	self.incomeLabel = nil;
	self.raceLabel = nil;
	self.martialLabel = nil;
	self.educationLabel = nil;
	self.occupationLabel = nil;
	
	self.editBirthdayController = nil;
	self.editGenderController = nil;
	self.editIncomingController = nil;
	self.editZipcodeController = nil;
	self.editRaceController = nil;
	self.editMartialController = nil;
	self.editEducationController = nil;
	self.editOccupationController = nil;
}


- (void)dealloc {
	[profileTable release]; 
	[emailCell release]; 
	[birthdayCell release]; 
	[genderCell release]; 
	[zipcodeCell release]; 
	[incomeCell release];
	[raceCell release];
	[martialCell release];
	[educationCell release];
	[occupationCell release];
	[emailLabel release]; 
	[birthdayLabel release]; 
	[genderLabel release]; 
	[zipcodeLabel release]; 
	[incomeLabel release]; 
	[raceLabel release];
	[martialLabel release];
	[educationLabel release];
	[occupationLabel release];
	
	[editBirthdayController release];
	[editGenderController release];
	[editIncomingController release];
	[editZipcodeController release];
	[editRaceController release];
	[editMartialController release];
	[editEducationController release];
	[editOccupationController release];
	
    [super dealloc];
}


#pragma mark -
#pragma mark LoginTable Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 9;
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
			zipcodeLabel.text = user.zipcode;
			return zipcodeCell;
		case 4:
			incomeLabel.text = user.income;
			return incomeCell;
		case 5:
			raceLabel.text = user.race;
			return raceCell;
		case 6:
			martialLabel.text = user.martial;
			return martialCell;
		case 7:
			educationLabel.text = user.education;
			return educationCell;
		case 8:
			occupationLabel.text = user.occupation;
			return occupationCell;
		default:
			break;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	switch (indexPath.row) {
		case 1:
			[self.navigationController pushViewController:self.editBirthdayController animated:YES];
			break;
		case 2:
			[self.navigationController pushViewController:self.editGenderController animated:YES];
			break;
		case 3:
			[self.navigationController pushViewController:self.editZipcodeController animated:YES];
			break;
		case 4:
			[self.navigationController pushViewController:self.editIncomingController animated:YES];
			break;
		case 5:
			[self.navigationController pushViewController:self.editRaceController animated:YES];
			break;
		case 6:
			[self.navigationController pushViewController:self.editMartialController animated:YES];
			break;
		case 7:
			[self.navigationController pushViewController:self.editEducationController animated:YES];
			break;
		case 8:
			[self.navigationController pushViewController:self.editOccupationController animated:YES];
			break;
		default:
			break;
	}
}

- (EditBirthdayController *)editBirthdayController {
	if (editBirthdayController == nil) {
		EditBirthdayController *ebc = [[EditBirthdayController alloc] initWithNibName:@"EditBirthdayView" bundle:nil];
		self.editBirthdayController = ebc;
		[ebc release];
	}
	return editBirthdayController;
}

- (EditGenderController *)editGenderController {
	if (editGenderController == nil) {
		EditGenderController *egc = [[EditGenderController alloc] initWithNibName:@"EditGenderView" bundle:nil];
		self.editGenderController = egc;
		[egc release];
	}
	return editGenderController;
}

- (EditZipcodeController *)editZipcodeController {
	if (editZipcodeController == nil) {
		EditZipcodeController *ezc = [[EditZipcodeController alloc] initWithNibName:@"EditZipcodeView" bundle:nil];
		self.editZipcodeController = ezc;
		[ezc release];
	}
	return editZipcodeController;
}

- (EditIncomingController *)editIncomingController {
	if (editIncomingController == nil) {
		EditIncomingController *eic = [[EditIncomingController alloc] initWithNibName:@"EditIncomingView" bundle:nil];
		self.editIncomingController = eic;
		[eic release];
	}
	return editIncomingController;
}

- (EditRaceController *)editRaceController {
	if (editRaceController == nil) {
		EditRaceController *erc = [[EditRaceController alloc] initWithNibName:@"EditRaceView" bundle:nil];
		self.editRaceController = erc;
		[erc release];
	}
	return editRaceController;
}

- (EditMartialController *)editMartialController {
	if (editMartialController == nil) {
		EditMartialController *emc = [[EditMartialController alloc] initWithNibName:@"EditMartialView" bundle:nil];
		self.editMartialController = emc;
		[emc release];
	}
	return editMartialController;
}

- (EditEducationController *)editEducationController {
	if (editEducationController == nil) {
		EditEducationController *eec = [[EditEducationController alloc] initWithNibName:@"EditEducationView" bundle:nil];
		self.editEducationController = eec;
		[eec release];
	}
	return editEducationController;
}

- (EditOccupationController *)editOccupationController {
	if (editOccupationController == nil) {
		EditOccupationController *eoc = [[EditOccupationController alloc] initWithNibName:@"EditOccupationView" bundle:nil];
		self.editOccupationController = eoc;
		[eoc release];
	}
	return editOccupationController;
}

@end
