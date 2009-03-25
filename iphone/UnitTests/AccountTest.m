#import "GTMSenTestCase.h"
#import "Account.h"
#import "Rest.h"



@interface AccountTest : GTMTestCase{
	NSDateFormatter *dateFormatter;
	Account *account;
	NSInteger accountChangeNotificationCount;
}
@property(nonatomic, retain) Account* account;
@end





@implementation AccountTest
@synthesize account;

-(void)accountChanged:(Account*)_account{
	STAssertEquals(account, _account, nil);
	accountChangeNotificationCount++;
}

- (void)setUp{
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"dd MMM yyyy";
	self.account = [[[Account alloc] init] autorelease];
	[account onChangeNotify:@selector(accountChanged:) on:self];
	accountChangeNotificationCount = 0;

}

- (void)tearDown{
	[dateFormatter release];
	self.account = nil;
}


-(void)testPopulationWithMostlyEmptyData{
	NSString *data = @"{\"user\": { \"id\": 123},\"birthdate\": null}";
	[account finishedLoading:data];
	STAssertEquals(123, account.itemId, nil);

}


-(void)testPopulationFromRestDidFinishLoading{
	NSString *data = @"{\"user\": { \"birthdate\": \"1973-03-27\", \"id\": 123, \"gender\":\"M\", \"login\": \"marvin\", \"income\": \"25283\", \"email\": \"marvin@example.com\"}}";

	[account finishedLoading:data];

	STAssertEquals(123, account.itemId, nil);
	STAssertEqualStrings(@"marvin", account.username,nil);
	STAssertEqualStrings(@"marvin@example.com", account.email, nil);
	STAssertEqualStrings(@"M", account.gender, nil);
	STAssertEquals(25283, account.income, nil);
	STAssertEqualStrings(@"27 Mar 1973", [dateFormatter stringFromDate:account.birthdate], nil);
	STAssertEquals(1, accountChangeNotificationCount, @"accountChangeNotificationCount");
	STAssertEquals(accountLoadStatusLoaded, account.accountLoadStatus, @"accountLoadStatus");
}



-(void)testNewFromDictionaryWith_NSNull_Birthdate{
	NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"456", [NSNull null],  nil] forKeys:[NSArray arrayWithObjects:@"id", @"birthdate", nil]];
	NSDictionary *user = [NSDictionary dictionaryWithObject:params forKey:@"user"];
	self.account = [[Account newFromDictionary:user] autorelease];
	STAssertEquals(456, account.itemId, nil);
	STAssertNULL(account.birthdate, nil);
}

-(void)testBecomesUnauthorisedWhenUnauthorised{
	[account authenticationFailed];
	STAssertEquals(accountLoadStatusUnauthorized, account.accountLoadStatus, @"accountLoadStatus");
	STAssertEquals(1, accountChangeNotificationCount, @"accountChangeNotificationCount");
}

-(void)testStatusBecomesFailedOnError{
	NSError *error = [NSError errorWithDomain:@"test.host" code:NSURLErrorTimedOut userInfo:nil];
	[account failedWithError:error];
	STAssertEquals(accountLoadStatusLoadFailed, account.accountLoadStatus, @"accountLoadStatus");
	STAssertEquals(1, accountChangeNotificationCount, @"accountChangeNotificationCount");
	STAssertEqualStrings(error, account.lastLoadError, @"lastLoadError");
}



-(void)testNewFromDictionary{
	NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"rita", @"456",  nil] forKeys:[NSArray arrayWithObjects:@"login", @"id", nil]];
	NSDictionary *user = [NSDictionary dictionaryWithObject:params forKey:@"user"];
	self.account = [[Account newFromDictionary:user] autorelease];
	STAssertEquals(456, account.itemId, nil);
	STAssertEqualStrings(@"rita", account.username, nil);

}

-(void)testCreate{
    account.birthdate = [dateFormatter dateFromString:@"15 July 1969"];
    account.email = @"bobby@bobo.net";
    account.username = @"bobby";
    account.password = @"pingupanga";
    account.income = 12345;
    account.gender = @"F";
    
    [account createNew];
}


-(void)testProperlyInitialised{
	STAssertEquals(0, (NSInteger) account.errors.count, nil);
	STAssertNotNil(account.rest, nil);
}

@end
