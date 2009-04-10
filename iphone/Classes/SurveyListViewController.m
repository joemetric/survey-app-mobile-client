#import "SurveyListViewController.h"
#import "SurveyListViewTableCell.h"
#import "SurveyInfoViewController.h"
#import "Survey.h"

@interface SurveyListViewController (Private)
- (NSString*) surveyTotalAsText;
@end

@implementation SurveyListViewController

@synthesize surveys, tableView, cashLabel ;

- (void)awakeFromNib {
}

-(void)refreshSurveys {
    NSLog(@"Loading surveys from the disk");
    self.surveys = [Survey findAll];
	NSLog(@"surveys: %d", self.surveys.count);
    [self.tableView reloadData];
	self.cashLabel.text = [self surveyTotalAsText];
}

- (NSString*) surveyTotalAsText {
	float total = 0.0;
	for( Survey* survey in self.surveys ) {
		NSLog(@"total=%f, adding=%f", total, [survey.amount floatValue]);
		total += [survey.amount floatValue];
	}
	
	NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	NSString* totalString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:total]];
	[numberFormatter release];
	return totalString;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshSurveys];
	[super viewDidAppear:animated];
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	NSLog(@"number of rows %d", [self.surveys count]);
    return [self.surveys count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"cell requested");
    SurveyListViewTableCell *cell = (SurveyListViewTableCell*)[tableView dequeueReusableCellWithIdentifier:@"SurveyListViewTableCell"];
    if (cell == nil) {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SurveyListViewTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    Survey *survey = [self.surveys objectAtIndex:indexPath.row];
	cell.surveyName.text  = survey.name;
	cell.surveyValue.text = [survey amountAsDollarString];
	
	if( indexPath.row % 2 == 1 ) {
		cell.backgroundView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	} else {
		cell.backgroundView.backgroundColor = [UIColor whiteColor];
	}
    return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UINavigationController* surveyController = [[UINavigationController alloc] init];
	surveyController.navigationBar.tintColor = [UIColor colorWithRed:12.0/256.0 green:43.0/256.0 blue:64.0/256.0 alpha:1.0];


    SurveyInfoViewController *sivc = [[SurveyInfoViewController alloc] initWithNibName:@"SurveyInfoView"
                                                                       bundle:nil
                                                                       survey:[self.surveys objectAtIndex:indexPath.row]];
	[surveyController pushViewController:sivc animated:YES];
	[sivc release];
    [self presentModalViewController:surveyController animated:YES];
    [surveyController release];
}

- (void)dealloc {
    [surveys release];
	[tableView release];
	[cashLabel release];
    [super dealloc];
}


@end

