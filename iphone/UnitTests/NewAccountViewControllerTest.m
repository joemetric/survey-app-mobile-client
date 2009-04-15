#import "GTMSenTestCase.h"
#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "MaleFemaleTableViewCell.h"
#import "RestStubbing.h"
#import "NSString+Regex.h"
#import "AccountStubbing.h"
#import "DateHelper.h"
#import "NSString+Regex.h"
#import "Editable.h"


@interface NewAccountViewControllerTest: GTMTestCase{
	NewAccountViewController* testee;
}

@end


@implementation NewAccountViewControllerTest

-(void)setUp{
	gAccount = [[Account alloc] init];
	testee = [[NewAccountViewController alloc] initWithNibName:@"NewAccountView" bundle:nil];
	[[NSBundle mainBundle] loadNibNamed:@"NewAccountView" owner:testee options:nil];
	[testee viewDidLoad];
	resetRestStubbing();
   
}

-(void)tearDown{
	[testee release];
	[gAccount release];
}


-(id<Editable>)labelledCellForRow:(NSInteger)row inSection:(NSInteger)section{
    id<UITableViewDataSource> dataSource = testee.tableView.dataSource;
	return (id<Editable>) [dataSource tableView:testee.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
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
    STAssertEquals(4, [testee.tableView numberOfRowsInSection:0], @"rows in section 0");
}

-(void)testDemographicsSectionCellLabels{
	[self assertLabel:@"Income" inLabelledCellForRow:0 inSection:1];
	[self assertLabel:@"Birthdate" inLabelledCellForRow:1 inSection:1];
	[self assertLabel:@"gender" inLabelledCellForRow:2 inSection:1];
    STAssertEquals(3, [testee.tableView numberOfRowsInSection:1], @"rows in section 1");
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
	[testee changeInAccount:gAccount];
	STAssertFalse([testee.activityIndicator isAnimating], nil);
}


-(void)testDisplayErrorInFooters{
	NSString* data = @"[[\"login\", \"silly login\"]]";
	[gAccount finishedLoading:data];
	UIView* footer = [testee.tableView.delegate tableView:nil viewForFooterInSection:0];
	STAssertEquals((NSUInteger)1, footer.subviews.count, @"footer error count");
	STAssertEqualStrings(@"login silly login", [[footer.subviews objectAtIndex:0] text], nil);
}


-(void)assertRow:(NSInteger)row inSection:(NSInteger)section highlighted:(BOOL)highlighted{
	id<Editable> cell = [self labelledCellForRow:row inSection:section];
	STAssertEquals(highlighted, cell.errorHighlighted, 
		[NSString stringWithFormat:@"%@ expected to be%@highlighted.", cell.label.text, 
		highlighted ? @" " : @" not "]);
}

-(void)testOnlyLabelWithErrorIsHighlighted{
	NSString* data = @"[[\"login\", \"silly login\"]]";
	[gAccount finishedLoading:data];
	[self assertRow:0 inSection:0 highlighted:YES];
	[self assertRow:1 inSection:0 highlighted:NO];	 
}

-(void)testRowsAndSectionCounts{
	STAssertEquals(2, [testee.tableView numberOfSections], @"numberOfSectionsInTableView");
	STAssertEquals(4, [testee.tableView numberOfRowsInSection:0], @"numberOfRowsInSection:0");
	STAssertEquals(3, [testee.tableView numberOfRowsInSection:1], @"numberOfRowsInSection:1");
}

-(void)testEachFieldHighlightedIfInError{
	NSString* data = @"[[\"login\", \"\"], [\"email\", \"\"],[\"password\", \"\"], [\"password_confirmation\", \"\"],[\"birthdate\", \"\"], [\"income\", \"\"], [\"gender\", \"\"]]";
	[gAccount finishedLoading:data];
	for (int section = 0; section < [testee.tableView numberOfSections]; section++){
		for (int row = 0; row < [testee.tableView numberOfRowsInSection:section]; row++){
			if (!(section == 1 && row == 2)){ // ignore gender - todo less rubbish
				[self assertRow:row inSection:section highlighted:YES];
			}
		}
	}	
}


-(void)testFieldNotHighligtedIfErrorNoLongerPresent{
	[gAccount finishedLoading:@"[[\"login\", \"silly login\"]]"];
	[gAccount finishedLoading:@"[[\"income\", \"too much\"]]"];
	[self assertRow:0 inSection:0 highlighted:NO];
	
}

@end
