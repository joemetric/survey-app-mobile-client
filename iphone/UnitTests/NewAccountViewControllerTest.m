#import "GTMSenTestCase.h"
#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "SegmentedTableViewCell.h"
#import "RestStubbing.h"
#import "NSString+Regex.h"
#import "AccountStubbing.h"
#import "DateHelper.h"
#import "NSString+Regex.h"

@interface NewAccountViewControllerTest: GTMTestCase{
	NewAccountViewController* testee;
}

@end


@implementation NewAccountViewControllerTest

-(void)setUp{
	testee = [[NewAccountViewController alloc] initWithNibName:@"NewAccountView" bundle:nil];
	NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"NewAccountView" owner:testee options:nil];
	for (id obj in nib){
		NSLog(@"Obj: %@", obj);
	}
	resetRestStubbing();
	gAccount = [[Account alloc] init];
   
}

-(void)tearDown{
	[testee release];
	[gAccount release];
}


-(LabelledTableViewCell*)labelledCellForRow:(NSInteger)row inSection:(NSInteger)section{
	return (LabelledTableViewCell*)[testee tableView:testee.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

-(void)assertLabel:(NSString*)label inLabelledCellForRow:(NSInteger)row inSection:(NSInteger)section{
	LabelledTableViewCell* cell = [self labelledCellForRow:row inSection:section];
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
	testee.dobCell.textField.text = @"23 Oct 1967";
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

-(void)assertFooterInSection:(NSInteger)section matchesRegex:(NSString*)regex{
	NSString *footer = [testee tableView:nil titleForFooterInSection:section];
	STAssertNotNil([footer matchRegex:regex], [NSString stringWithFormat:@"Looking for '%@' in \n'%@'", regex, footer]);
}

-(void)testDisplayErrorInMainFooter{
	NSString* data = @"[[\"login\", \"silly login\"], [\"login\", \"should not be bob\"], [\"email\", \"should be cool\"]]";
	[gAccount finishedLoading:data];
	[self assertFooterInSection:0 matchesRegex:@"silly login"];
	[self assertFooterInSection:0 matchesRegex:@"should not be bob"];
	[self assertFooterInSection:0 matchesRegex:@"should be cool"];
	STAssertEqualStrings(@"", [testee tableView:nil titleForFooterInSection:1], nil);
	
}

-(void)testDisplayErrorInDemographicsFooter{
	NSString* data = @"[[\"birthdate\", \"too young\"], [\"income\", \"too much\"], [\"gender\", \"neuter\"]]";
	[gAccount finishedLoading:data];
	[self assertFooterInSection:1 matchesRegex:@"too much"];
	[self assertFooterInSection:1 matchesRegex:@"neuter"];
	[self assertFooterInSection:1 matchesRegex:@"too young"];
}

-(void)assertRow:(NSInteger)row inSection:(NSInteger)section highlighted:(BOOL)highlighted{
	LabelledTableViewCell* cell = [self labelledCellForRow:row inSection:section];
	UIColor* expectedColour = highlighted ? [UIColor redColor] : [UIColor blackColor];
	STAssertEquals(expectedColour, cell.label.textColor, 
		[NSString stringWithFormat:@"%@ expected to be%@highlighted.", cell.label.text, 
		highlighted ? @" " : @" not "]);
}

-(void)testOnlyLabelWithErrorIsHighlighted{
	NSString* data = @"[[\"login\", \"silly login\"]]";
	[gAccount finishedLoading:data];
	[self assertRow:0 inSection:0 highlighted:YES];
	[self assertRow:1 inSection:0 highlighted:NO];	
}

-(void)testEachFieldHighlightedIfInError{
	NSString* data = @"[[\"login\", \"\"], [\"email\", \"\"],[\"password\", \"\"], [\"password_confirmation\", \"\"],[\"birthdate\", \"\"], [\"income\", \"\"], [\"gender\", \"\"]]";
	[gAccount finishedLoading:data];
	for (int section = 0; section < [testee numberOfSectionsInTableView:nil]; section++){
		for (int row = 0; row < [testee tableView:nil numberOfRowsInSection:section]; row++){
			[self assertRow:row inSection:section highlighted:YES];
		}
	}	
}


-(void)testFieldNotHighligtedIfErrorNoLongerPresent{
	[gAccount finishedLoading:@"[[\"login\", \"silly login\"]]"];
	[gAccount finishedLoading:@"[[\"income\", \"too much\"]]"];
	[self assertRow:0 inSection:0 highlighted:NO];
	
}

@end
