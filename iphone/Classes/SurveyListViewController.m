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
    [self.tableView reloadData];
	self.cashLabel.text = [self surveyTotalAsText];
}

- (NSString*) surveyTotalAsText {
	float total;
	for( Survey* survey in self.surveys ) {
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

- (void)viewDidAppear:(BOOL)animated {
    [self refreshSurveys];
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return [self.surveys count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SurveyListViewTableCell *cell = (SurveyListViewTableCell*)[tableView dequeueReusableCellWithIdentifier:@"SurveyListViewTableCell"];
    if (cell == nil) {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SurveyListViewTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    Survey *survey = [self.surveys objectAtIndex:indexPath.row];
	cell.surveyName.text  = survey.name;
	cell.surveyValue.text = [survey amountAsDollarString];
	
	if( indexPath.row % 2 == 1 ) {
		cell.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	} else {
		cell.contentView.backgroundColor = [UIColor whiteColor];
	}
    return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SurveyInfoViewController *sivc = [[SurveyInfoViewController alloc] initWithNibName:@"SurveyInfoView"
//                                                                       bundle:nil
//                                                                       survey:[self.surveys objectAtIndex:indexPath.row]];
//
//    [self.navigationController pushViewController:sivc animated:YES];
//    [sivc release];
}

- (void)dealloc {
    [surveys release];
	[tableView release];
	[cashLabel release];
    [super dealloc];
}


@end

