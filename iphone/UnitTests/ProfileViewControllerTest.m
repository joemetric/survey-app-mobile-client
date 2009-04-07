#import "GTMSenTestCase.h"
#import "ProfileViewController.h"
#import "Account.h"
#import "NoAccountDataProfileDataSource.h"
#import "ValidCredentialsProfileDataSource.h"
#import "NoCredentialsProfileDataSource.h"
#import "AccountStubbing.h"


NSInteger gProfileViewControllerTableReloadedCount;
NSInteger gModalViewControllerDismissCount;

@interface ProfileViewController(ProfileViewControllerTestPeek)
-(NSObject<UITableViewDelegate, UITableViewDataSource>*) tableDelegate;
@end

@interface ProfileViewController(ProfileViewControllerTest)
@end

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
}

-(void)tearDown{
	[testee release];
	[gAccount release];
    
}



-(void)assertTableDelegateIsExpectedType:(Class)expectedType forAccountLoadStatus:(AccountLoadStatus)accountLoadStatus describedAs:(NSString*)description{
	[gAccount  setAccountLoadStatus:accountLoadStatus];
	[testee viewDidLoad];
	STAssertEqualStrings(expectedType, [[testee tableDelegate] class], description); 
	
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



-(void)XXXXXtestTableDelegateDataSourceIsAppropriateForTheCurrentAccountLoadStatus{
	[self assertTableDelegateIsExpectedType:[NoAccountDataProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusNotLoaded describedAs:@"not loaded"];
	STAssertEqualStrings(@"Loading account details.", [testee tableView:nil titleForFooterInSection:0], nil);
	
	[self assertTableDelegateIsExpectedType:[ValidCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusLoaded describedAs:@"loaded"];
	[self assertTableDelegateIsExpectedType:[NoAccountDataProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusLoadFailed describedAs:@"load failed"];
	STAssertEqualStrings(@"Unable to load account details.", [testee tableView:nil titleForFooterInSection:0], nil);
	[self assertTableDelegateIsExpectedType:[NoCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusUnauthorized describedAs:@"unauthorised"];
	[self assertTableDelegateIsExpectedType:[NoCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusFailedValidation describedAs:@"not loaded"];
}


-(void)allDataSourcesImplementTableViewViewForHeaderInSection{
	for (int i = accountLoadStatusNotLoaded; i < accountLoadStatusFailedValidation; i++){
		[testee tableView:nil viewForHeaderInSection:0];
	}
}

-(void)testTableReloadedWhenAccountChanges{
	[testee viewDidLoad];
	[gAccount authenticationFailed];
	STAssertEquals(1, gProfileViewControllerTableReloadedCount, nil);	
}





@end
