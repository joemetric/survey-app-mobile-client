#import "GTMSenTestCase.h"
#import "ProfileViewController.h"
#import "Account.h"
#import "NoAccountDataProfileDataSource.h"
#import "ValidCredentialsProfileDataSource.h"
#import "NoCredentialsProfileDataSource.h"
#import "AccountStubbing.h"
#import "NSObject+CleanUpProperties.h"
#import "EditProfileDataSource.h"
#import "StubbedTextView.h"
#import "LabelledTableViewCell.h"


NSInteger gProfileViewControllerTableReloadedCount;
NSInteger gModalViewControllerDismissCount;


@implementation ProfileViewController(ProfileViewControllerTest)
- (void)dismissModalViewControllerAnimated:(BOOL)animated{
	gModalViewControllerDismissCount++;
}
	
@end


	
@interface UITableView(ProfileViewControllerTest)
- (void)reloadData;
@end

@implementation UITableView(ProfileViewControllerTest)
- (void)reloadData{
	gProfileViewControllerTableReloadedCount++;
}
@end




@interface ProfileViewControllerTest : GTMTestCase{
	ProfileViewController *testee;

}
@end

@implementation ProfileViewControllerTest

-(void)setUp{
    gAccount = [[Account alloc] init];
	gProfileViewControllerTableReloadedCount = 0;
	gModalViewControllerDismissCount = 0;
	testee = [[ProfileViewController alloc] init];
	testee.tableView = [[UITableView alloc] init];
	[testee viewDidLoad];
}

-(void)tearDown{
	[testee release];
	[gAccount release];
}



-(void)testModalViewControllerDismissedIfAccountLoadStatusBecomes_accountLoadStatusLoaded{
	[gAccount  setAccountLoadStatus:accountLoadStatusLoaded];	
	[testee changeInAccount:gAccount];
	STAssertEquals(1, gModalViewControllerDismissCount, nil);	
}

-(void)testModalViewControllerNotDismissedIfAccountLoadStatusBecomesNotLoaed{
	[gAccount  setAccountLoadStatus:accountLoadStatusLoadFailed];	
	[testee changeInAccount:gAccount];
	STAssertEquals(0, gModalViewControllerDismissCount, nil);	
}

-(void)assertTableDelegateIsExpectedType:(Class)expectedType forAccountLoadStatus:(AccountLoadStatus)accountLoadStatus describedAs:(NSString*)description{
	[gAccount  setAccountLoadStatus:accountLoadStatus];
	[testee changeInAccount:gAccount];
	STAssertEqualObjects(expectedType, [testee.tableView.dataSource class], description); 
}


-(void)testTableDelegateDataSourceIsAppropriateForTheCurrentAccountLoadStatus{
	[self assertTableDelegateIsExpectedType:[NoAccountDataProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusNotLoaded describedAs:@"not loaded"];
	
	[self assertTableDelegateIsExpectedType:[ValidCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusLoaded describedAs:@"loaded"];
	[self assertTableDelegateIsExpectedType:[NoAccountDataProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusLoadFailed describedAs:@"load failed"];
	[self assertTableDelegateIsExpectedType:[NoCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusUnauthorized describedAs:@"unauthorised"];
	[self assertTableDelegateIsExpectedType:[NoCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusFailedValidation describedAs:@"not loaded"];
}


-(void)testTableReloadedWhenAccountChanges{
	[gAccount authenticationFailed];
	STAssertEquals(1, gProfileViewControllerTableReloadedCount, nil);	
}


-(void)testEditButtonPresentOnlyIfTableDelegateTypeIsForValidCredentials{
	[gAccount  setAccountLoadStatus:accountLoadStatusNotLoaded];
	[testee changeInAccount:gAccount];
	STAssertNil(testee.navigationItem.rightBarButtonItem, @"no edit button for not loaded status");

	[gAccount  setAccountLoadStatus:accountLoadStatusLoaded];
	[testee changeInAccount:gAccount];
	STAssertNotNil(testee.navigationItem.rightBarButtonItem, @"edit button present if in loaded status");
	
}




-(void)testDataSourceChangedToEditingWhenEditButtonPressed{
	[gAccount  setAccountLoadStatus:accountLoadStatusLoaded];
	STAssertFalse(testee.isEditing, @"view is initially not editing");
	[testee setEditing:YES animated:YES];
	STAssertTrue(testee.isEditing, @"view is editing");
	STAssertEqualObjects([EditProfileDataSource class], [testee.tableView.dataSource class], @"data source"); 		
}

-(void)testWhenDoneEditingRemainsInEditingStateUntilAccountCallbackReceived{
	[gAccount  setAccountLoadStatus:accountLoadStatusLoaded];
	[testee setEditing:YES animated:YES];
	[testee setEditing:NO animated:YES];
	STAssertTrue(testee.isEditing, @"view is editing");	
}

-(void)testBecomesNongerEditingWhenEditingAndAccountStatusChangesToLoaded{
	[testee setEditing:YES animated:YES];
	[gAccount  setAccountLoadStatus:accountLoadStatusLoaded];
	[testee changeInAccount:gAccount];
	STAssertFalse(testee.isEditing, @"view is editing");		
}


-(void)testWhenEditingAndAccountStatusChangesToLoadedValidViewIsShown{
	[testee setEditing:YES animated:YES];
	[gAccount  setAccountLoadStatus:accountLoadStatusLoaded];
	[testee changeInAccount:gAccount];
	STAssertEqualObjects([ValidCredentialsProfileDataSource class], [testee.tableView.dataSource class], nil); 
}

-(void)testWhenEditingAndAccountStatusChangesToFailedValidationEditingViewIsShown{
	[testee setEditing:YES animated:YES];
	[gAccount  setAccountLoadStatus:accountLoadStatusFailedValidation];
	[testee changeInAccount:gAccount];
	STAssertEqualObjects([EditProfileDataSource class], [testee.tableView.dataSource class], nil); 
	STAssertTrue(testee.isEditing, @"view is editing");	
}

-(void)testResignsFirstResponderWhenFinishingEditing{
	[testee setEditing:YES animated:YES];
	StubbedTextView* text = [[[StubbedTextView alloc] init] autorelease];
	((EditProfileDataSource* )testee.currentDataSource).emailCell.textField = text;
	[text becomeFirstResponder];
	[testee setEditing:NO animated:YES];
	STAssertFalse(text.isFirstResponder, nil);
	
}


-(void)testEditDataViewShowsMostUptoDateVersionOfAccountDetails{
	gAccount.email = @"new@email.com";
	[testee setEditing:YES animated:YES];
	
	LabelledTableViewCell* cell = [testee.tableView.delegate tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
	STAssertEqualStrings(@"email", cell.label.text, nil); // double check we're on the right cell
	STAssertEqualStrings(@"new@email.com", cell.textField.text, nil); // double check we're on the right cell	
	
}
// TODO Fails to update

// TODO actually updates


@end
