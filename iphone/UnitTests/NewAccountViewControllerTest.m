#import "GTMSenTestCase.h"
#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "SegmentedTableViewCell.h"
#import "RestStubbing.h"
#import "NSString+Regex.h"
#import "AccountStubbing.h"
#import "DateHelper.h"
#import "NSString+Regex.h"
#import "HasError.h"


@interface NewAccountViewControllerTest: GTMTestCase{
	NewAccountViewController* testee;
}

@end


@implementation NewAccountViewControllerTest

-(void)setUp{
	testee = [[NewAccountViewController alloc] initWithNibName:@"NewAccountView" bundle:nil];
	[[NSBundle mainBundle] loadNibNamed:@"NewAccountView" owner:testee options:nil];
	[testee viewDidLoad];
	resetRestStubbing();
	gAccount = [[Account alloc] init];
   
}

-(void)tearDown{
	[testee release];
	[gAccount release];
}


-(id<Labelled, HasError>)labelledCellForRow:(NSInteger)row inSection:(NSInteger)section{
	return (id<Labelled, HasError>) [testee tableView:testee.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

-(void)assertLabel:(NSString*)label inLabelledCellForRow:(NSInteger)row inSection:(NSInteger)section{
	id<Labelled> cell = [self labelledCellForRow:row inSection:section];
	STAssertEqualStrings(label, cell.label.text, [NSString stringWithFormat:@"row: %d, section: %d", row, section]);
	
}


-(void)testMainSectionCellLabels{
	[self assertLabel:@"Login" inLabelledCellForRow:0 inSection:0];
	[self assertLabel:@"Password" inLabelledCellForRow:1 inSection:0];
	[self assertLabel:@"Confirm P/W" inLabelledCellForRow:2 inSection:0];
	[self assertLabel:@"Email" inLabelledCellForRow:3 inSection:0];   
    STAssertEquals(4, [testee tableView:nil numberOfRowsInSection:0], @"rows in section 0");
}

-(void)testDemographicsSectionCellLabels{
	[self assertLabel:@"Income" inLabelledCellForRow:0 inSection:1];
	[self assertLabel:@"Birthdate" inLabelledCellForRow:1 inSection:1];
	[self assertLabel:@"Gender" inLabelledCellForRow:2 inSection:1];
    STAssertEquals(3, [testee tableView:nil numberOfRowsInSection:1], @"rows in section 1");
}


-(void)testSignupSendsPostToServer{
	testee.loginCell.textField.text = @"mavis";
	STAssertEqualStrings(@"mavis", testee.loginCell.textField.text , nil);
	[testee signup];
	STAssertNotNil(connectionRequest, @"request sent");
	STAssertEqualStrings(@"http://localhost:3000/users.json", [[connectionRequest URL] relativeString], @"url");
	STAssertEqualStrings(@"POST", connectionRequest.HTTPMethod, @"http method");
    STAssertNotNil([ [connectionRequest httpBodyAsString] matchRegex:@"\"login\":\"mavis\""],  [connectionRequest httpBodyAsString]);
	
}

-(void)testFieldsSetOnAccountOnSignup{
	testee.loginCell.textField.text = @"rita";
	testee.passwordCell.textField.text = @"rita's secret";
	testee.passwordConfirmationCell.textField.text = @"rita's slip";
	testee.emailCell.textField.text = @"rita@ryvita.nyet";
	testee.incomeCell.textField.text = @"123451";
	testee.dobCell.textField.text = [DateHelper localDateFormatFromDateString:@"23 Oct 1967"];
	testee.genderCell.segControl.selectedSegmentIndex = 0;
			
	[testee signup];
	STAssertEqualStrings(@"rita", gAccount.username, @"username");
	STAssertEqualStrings(@"rita's secret", gAccount.password, @"password");
	STAssertEqualStrings(@"rita's slip", gAccount.passwordConfirmation, @"password confirm");
	STAssertEqualStrings(@"rita@ryvita.nyet", gAccount.email, @"email");
	STAssertEquals(123451, gAccount.income, @"income");
	STAssertEqualStrings(@"M", gAccount.gender, @"gender");
	STAssertEqualStrings(@"23 Oct 1967", [DateHelper stringFromDate:gAccount.birthdate], @"birthdate");


	testee.genderCell.segControl.selectedSegmentIndex = 1;			
	[testee signup];
	STAssertEqualStrings(@"F", gAccount.gender, @"gender");
	
}

-(void)testActivityIndicatorSpinsOnSignup{
	[testee signup];
	STAssertTrue([testee.activityIndicator isAnimating], nil);
}

-(void)testActivityIndicatorStopsAnimatingOnAccountChanged{
	[testee signup];
	[testee accountChanged];
	STAssertFalse([testee.activityIndicator isAnimating], nil);
}


-(void)testDisplayErrorInFooters{
	NSString* data = @"[[\"login\", \"silly login\"]]";
	[gAccount finishedLoading:data];
	[testee accountChanged];
	UIView* footer = [testee tableView:nil viewForFooterInSection:0];
	STAssertEquals((NSUInteger)1, footer.subviews.count, @"footer error count");
	STAssertEqualStrings(@"login silly login", [[footer.subviews objectAtIndex:0] text], nil);
}


-(void)assertRow:(NSInteger)row inSection:(NSInteger)section highlighted:(BOOL)highlighted{
	id<HasError, Labelled> cell = [self labelledCellForRow:row inSection:section];
	STAssertEquals(highlighted, cell.errorHighlighted, 
		[NSString stringWithFormat:@"%@ expected to be%@highlighted.", cell.label.text, 
		highlighted ? @" " : @" not "]);
}

-(void)testOnlyLabelWithErrorIsHighlighted{
	NSString* data = @"[[\"login\", \"silly login\"]]";
	[gAccount finishedLoading:data];
	[testee accountChanged];
	[self assertRow:0 inSection:0 highlighted:YES];
	[self assertRow:1 inSection:0 highlighted:NO];	 
}

-(void)testRowsAndSectionCounts{
	STAssertEquals(2, [testee numberOfSectionsInTableView:nil], @"numberOfSectionsInTableView");
	STAssertEquals(4, [testee tableView:nil numberOfRowsInSection:0], @"numberOfRowsInSection:0");
	STAssertEquals(3, [testee tableView:nil numberOfRowsInSection:1], @"numberOfRowsInSection:1");
}

-(void)testEachFieldHighlightedIfInError{
	NSString* data = @"[[\"login\", \"\"], [\"email\", \"\"],[\"password\", \"\"], [\"password_confirmation\", \"\"],[\"birthdate\", \"\"], [\"income\", \"\"], [\"gender\", \"\"]]";
	[gAccount finishedLoading:data];
	[testee accountChanged];
	for (int section = 0; section < [testee numberOfSectionsInTableView:nil]; section++){
		for (int row = 0; row < [testee tableView:nil numberOfRowsInSection:section]; row++){
			if (!(section == 1 && row == 2)){ // ignore gender - todo less rubbish
				[self assertRow:row inSection:section highlighted:YES];
			}
		}
	}	
}


-(void)testFieldNotHighligtedIfErrorNoLongerPresent{
	[gAccount finishedLoading:@"[[\"login\", \"silly login\"]]"];
	[gAccount finishedLoading:@"[[\"income\", \"too much\"]]"];
	[testee accountChanged];
	[self assertRow:0 inSection:0 highlighted:NO];
	
}

@end
