//
//  SettingsController.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "SettingsController.h"


@implementation SettingsController
@synthesize settingsTable;
@synthesize newSurveyAlertCell, locationSpecificSurveyCell, sortSurveyCell, fewestQuestionsCell;
@synthesize locationCell, sortCell, newestQuestionsCell, confirmationCell;
@synthesize newSurveyAlertButton, locatonSpecificSurveyButton, sortSurveyLabel;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	self.fewestQuestionsCell = nil;
	self.locationCell = nil;
	self.sortCell = nil;
	self.newestQuestionsCell = nil;
	self.confirmationCell = nil;
	self.newSurveyAlertButton = nil;
	self.sortSurveyLabel = nil;
	self.locatonSpecificSurveyButton = nil;
}


- (void)dealloc {
	[settingsTable release]; 
	[newSurveyAlertCell release]; 
	[locationSpecificSurveyCell release]; 
	[sortSurveyCell release]; 
	[fewestQuestionsCell release]; 
	[locationCell release]; 
	[sortCell release]; 
	[newestQuestionsCell release]; 
	[confirmationCell release]; 
	[newSurveyAlertButton release]; 
	[sortSurveyLabel release]; 
	[locatonSpecificSurveyButton release]; 
	
    [super dealloc];
}


#pragma mark -
#pragma mark LoginTable Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {							
	switch (indexPath.row) {
		case 0:
			return newSurveyAlertCell;
		case 1:
			return locationSpecificSurveyCell;
		case 2:
			return sortSurveyCell;
		case 3:
			return fewestQuestionsCell;
		case 4:
			return locationCell;
		case 5:
			return sortCell;
		case 6:
			return newestQuestionsCell;
		case 7:
			return confirmationCell;
		default:
			break;
	}
	return nil;
}

@end
