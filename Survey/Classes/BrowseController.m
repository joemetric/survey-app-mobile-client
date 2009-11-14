//
//  BrowseController.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "BrowseController.h"
#import "RestRequest.h"
#import "Survey.h"
#import "SurveyCell.h"
#import "SurveyController.h"


@implementation BrowseController

@synthesize surveyTable, instructionLabel;
@synthesize surveys;
@synthesize surveyController;

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
	
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[aiv setFrame:CGRectMake(0, 0, 22, 22)];
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:aiv];
	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButton release];
	[aiv release];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
	backButton.title = @"Cancel";
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	instructionLabel.hidden = YES;
	[self performSelectorInBackground:@selector(getSurveys) withObject:nil];
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
	self.instructionLabel = nil;
	self.surveyTable = nil;
	self.surveyController = nil;
	self.surveys = nil;
}


- (void)dealloc {
	[instructionLabel release]; 
	[surveyTable release]; 
	[surveys release];
	[surveyController release];
	
    [super dealloc];
}


- (void)getSurveys {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[(UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem.customView startAnimating];
	
	NSError *error;
	self.surveys = [RestRequest getSurveys:&error];
	[self performSelectorOnMainThread:@selector(surveyLoaded) withObject:nil waitUntilDone:YES];
	
	[(UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem.customView stopAnimating];
	[pool release];
}

- (void)builtNavigationTitle {
	if ([self.surveys count] > 0) {
		float total_cash = 0.0f;
		for (Survey *survey in self.surveys) {
			total_cash += [survey.total_payout floatValue];
		}
		UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 220, 44)];
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 22)];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.text = @"TOTAL CASH AVAILABLE";
		titleLabel.textAlignment = UITextAlignmentCenter;
		[titleView addSubview:titleLabel];
		[titleLabel release];
		UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 220, 22)];
		priceLabel.backgroundColor = [UIColor clearColor];
		priceLabel.textColor = [UIColor yellowColor];
		priceLabel.text = [NSString stringWithFormat:@"$%.2f", total_cash];
		priceLabel.textAlignment = UITextAlignmentCenter;
		[titleView addSubview:priceLabel];
		[priceLabel release];
		self.navigationItem.titleView = titleView;
		[titleView release];
	}	
}

- (void)surveyLoaded {
	if ([surveys count] > 0) {
		self.instructionLabel.hidden = TRUE;
	} else {
		self.instructionLabel.hidden = FALSE;
	}
	
	[surveyTable reloadData];
	
	[self builtNavigationTitle];
}

#pragma mark -
#pragma mark LoginTable Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if ([surveys count] > 0) {
		surveyTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		surveyTable.separatorColor = [UIColor grayColor];
	} else {
		surveyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
	return [surveys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"SurveyCell";
    
    SurveyCell *cell = (SurveyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SurveyCellView" owner:self options:nil];
		cell = [nib objectAtIndex:0];
    }
	
	Survey *survey = [surveys objectAtIndex:indexPath.row];
	[cell updateSurvey:survey];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];

	Survey *survey = [surveys objectAtIndex:indexPath.row];
	[self.surveyController setSurvey:survey];
	[self.navigationController pushViewController:self.surveyController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 36.0;
}

- (SurveyController *)surveyController {
	if (surveyController == nil) {
		SurveyController *sc = [[SurveyController alloc] initWithNibName:@"SurveyView" bundle:nil];
		self.surveyController = sc;
		[sc release];
	}
	return surveyController;
}

@end
