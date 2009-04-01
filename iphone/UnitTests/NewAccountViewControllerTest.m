#import "GTMSenTestCase.h"
#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "SegmentedTableViewCell.h"
#import "RestStubbing.h"
#import "NSString+Regex.h"
#import "AccountStubbing.h"
#import "DateHelper.h"

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

-(void)assertLabel:(NSString*)label inLabelledCellForRow:(NSInteger)row inSection:(NSInteger)section{
	LabelledTableViewCell* cell = (LabelledTableViewCell*)[testee tableView:testee.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
	STAssertEqualStrings(label, cell.label.text, [NSString stringWithFormat:@"row: %d, section: %d", row, section]);
	
}

-(void)assertLabel:(NSString*)label inSegmentedCellForRow:(NSInteger)row inSection:(NSInteger)section{
	SegmentedTableViewCell* cell = (SegmentedTableViewCell*)[testee tableView:testee.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
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
	[self assertLabel:@"Gender" inSegmentedCellForRow:2 inSection:1];
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


@end
