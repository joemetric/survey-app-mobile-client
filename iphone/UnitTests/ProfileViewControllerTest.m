#import "GTMSenTestCase.h"
#import "ProfileViewController.h"
#import "Account.h"

Account *gAccount;
NSInteger gProfileViewControllerTableReloadedCount;



@interface Account(ProfileViewControllerTest)
+(Account*) currentAccount;
-(void)setAccountLoadStatus:(AccountLoadStatus)loadStatus;

@end

@implementation Account(ProfileViewControllerTest)

+(Account*) currentAccount{
    return gAccount;
}

-(void)setAccountLoadStatus:(AccountLoadStatus)_status{
    accountLoadStatus = _status;
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


-(void) testWhenUnauthenticatedNoCredentialsProfileDataSource{
	[self assertTableDelegateIsExpectedType:[NoCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusUnauthorized describedAs:@"unauthorised"];
}


-(void)testWhenAccountLoadedStatusIsAnythingButUnauthenticatedValidCredentialsProfileDataSourceDataSouceIsShown{
	[self assertTableDelegateIsExpectedType:[ValidCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusNotLoaded describedAs:@"not loaded"];
	[self assertTableDelegateIsExpectedType:[ValidCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusLoaded describedAs:@"loaded"];
	[self assertTableDelegateIsExpectedType:[ValidCredentialsProfileDataSource class]
	 	forAccountLoadStatus:accountLoadStatusLoadFailed describedAs:@"load failed"];
}

-(void)testTableReloadedWhenAccountChanges{
	[testee viewDidLoad];
	[gAccount authenticationFailed];
	STAssertEquals(1, gProfileViewControllerTableReloadedCount, nil);	
}





@end
