#import "GTMSenTestCase.h"
#import "AccountStubbing.h"
#import "UIView+EasySubviewLabelAccess.h"
#import "RestStubbing.h"
#import "CredentialsViewController.h"
#import "LabelledTableViewCell.h"
#import "RestConfiguration.h"
#import "NSString+Regex.h"

@interface CredentialsViewControllerTest : GTMTestCase{
	CredentialsViewController* testee;
	UITableView* tableView;
}


@end

@implementation CredentialsViewControllerTest

-(void)setUp{
	gAccount = [[Account alloc] init];
	resetRestStubbing();
	testee = [[CredentialsViewController alloc] initWithNibName:@"CredentialsView" bundle:nil];
	[[NSBundle mainBundle] loadNibNamed:@"CredentialsView" owner:testee options:nil];
	tableView = testee.tableView;
	[testee viewDidLoad];
	[tableView numberOfSections]; // prime the table view

}

-(void)tearDown{
	[gAccount release];
	[testee release];
	resetRestStubbing();
}


-(LabelledTableViewCell*) usernameCell{
	return (LabelledTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

-(LabelledTableViewCell*) passwordCell{
	return (LabelledTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
}

-(NSString*) sectionFooterText{
	return [[tableView.delegate tableView:tableView viewForFooterInSection:0] labelText];
}

-(void)assertCellAtRow:(NSInteger) row inSection:(NSInteger)section hasLabelText:(NSString*)labelText{
	LabelledTableViewCell* cell=  (LabelledTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
	STAssertEqualStrings(labelText, [[cell label] text], nil);
}

-(void)testIsOfRightShape{
	STAssertNotNil(tableView, nil);
	STAssertEquals(1, [tableView numberOfSections], @"sections");
	STAssertEquals(2, [tableView numberOfRowsInSection:0], @"row count");
	STAssertEqualStrings(@"username",[self usernameCell].label.text, nil);
	STAssertEqualStrings(@"password",[self passwordCell].label.text, nil);
}

-(void)testUsernameAndPasswordInitialisedFromRestConfiguration{
	[RestConfiguration setUsername:@"Petya"];
	[RestConfiguration setPassword:@"passywordy"];
	[testee viewDidAppear:YES];
    STAssertNotNil([self usernameCell].textField, nil);
	STAssertEqualStrings(@"Petya", [self usernameCell].textField.text, nil);
	STAssertEqualStrings(@"passywordy", [self passwordCell].textField.text, nil);
}

-(void)testLoginSetsTheUsernameAndPassword{
	[self usernameCell].textField.text = @"Marvin";
	[self passwordCell].textField.text = @"Marvin's secret";

	[testee login:nil];

	STAssertEqualStrings(@"Marvin", [RestConfiguration username], nil);
	STAssertEqualStrings(@"Marvin's secret", [RestConfiguration password], nil);


}

-(void)testLoginStartsTheActivityIndicator{
	[testee login:nil];
	STAssertTrue([testee.activityIndicator isAnimating], nil);
}

-(void)testLoginReloadsAccount{
	[testee login:nil];
	STAssertNotNil(connectionRequest, @"connectionRequest");
	STAssertEqualStrings(@"http://localhost:3000/users/current.json", [[connectionRequest URL] relativeString], @"url");
}

-(void)testFooterReflectsFailureToAuthenticateWithNewDetails{
	[testee login:nil];
	[gAccount authenticationFailed];
	STAssertEqualStrings(@"Wrong username or password.", [self sectionFooterText], nil);
}

-(void)testStopsListeningToAccountOnceNotificationReceived{
	[testee login:nil];
	[gAccount authenticationFailed];
	STAssertFalse([gAccount isObserver:testee], nil);
}

-(void)testAccountChangeNotificationStopsTheActivityIndicator{	
	[testee login:nil];
	[gAccount authenticationFailed];	
	STAssertFalse([testee.activityIndicator isAnimating], nil);
}



-(void)testFooterReflectsError{
	[testee login:nil];
	NSError* error = [NSError errorWithDomain:@"test.host" code:NSURLErrorTimedOut userInfo:nil];
	[gAccount failedWithError:error];
	STAssertNotNil([[self sectionFooterText] matchRegex:@"Error"], nil);

}

-(void)testMessageChangesWithMultipleAttempts{
	[testee login:nil];
	NSError* error = [NSError errorWithDomain:@"test.host" code:NSURLErrorTimedOut userInfo:nil];
	[gAccount failedWithError:error];
	[testee login:nil];
	[gAccount authenticationFailed];
	STAssertEqualStrings(@"Wrong username or password.", [self sectionFooterText], nil);
}

-(void)testPasswordShouldHaveAppropriateInputTraits{
	STAssertTrue([self passwordCell].textField.secureTextEntry, @"secure");
	STAssertEquals(UITextAutocapitalizationTypeNone, [self passwordCell].textField.autocapitalizationType , @"no capitalisation");
	STAssertEquals(UITextAutocorrectionTypeNo, [self passwordCell].textField.autocorrectionType , @"no correction");
}

-(void)testUsernameShouldHaveAppropriateInputTraits{
	STAssertFalse([self usernameCell].textField.secureTextEntry, @"secure");
	STAssertEquals(UITextAutocapitalizationTypeNone, [self usernameCell].textField.autocapitalizationType , @"no capitalisation");
	STAssertEquals(UITextAutocorrectionTypeNo, [self usernameCell].textField.autocorrectionType , @"no correction");
}


@end
