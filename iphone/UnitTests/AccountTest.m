#import "GTMSenTestCase.h"
#import "Account.h"
#import "RestStubbing.h"
#import "NSString+Regex.h"
#import "RestConfiguration.h"
#import "DateHelper.h"



@interface AccountTest : GTMTestCase{
	Account *account;
	NSInteger accountChangeNotificationCount;
}
@property(nonatomic, retain) Account* account;
@end





@implementation AccountTest
@synthesize account;


-(void)testDM{
	NSLog(@"%@", [DateHelper class]);
}
-(void)accountChanged:(Account*)_account{
	STAssertEquals(account, _account, nil);
	accountChangeNotificationCount++;
}

- (void)setUp{
	self.account = [[[Account alloc] init] autorelease];
	[account onChangeNotify:@selector(accountChanged:) on:self];
	accountChangeNotificationCount = 0;
	resetRestStubbing();

}

- (void)tearDown{
	self.account = nil;
}


-(void)testPopulationWithMostlyEmptyData{
	NSString *data = @"{\"user\": { \"id\": 123},\"birthdate\": null}";
	[account finishedLoading:data];
	STAssertEquals(123, account.itemId, nil);

}

-(void)testUsernameAndPasswordTakenFromRestConfiguration{
	[RestConfiguration setUsername:@"rita"];
	[RestConfiguration setPassword:@"my little secret"];

	self.account = [[[Account alloc] init] autorelease];

	STAssertEqualStrings(@"rita", account.username, nil);
	STAssertEqualStrings(@"my little secret", account.password, nil);
}


-(void)testWhenCreatingNewOnAccountDetailsLodedUsernameAndPasswordSavedToRestConfiguration{
	account.username = @"marvin";
	account.password = @"sue's secret";

	[account createNew];
	[account finishedLoading:@"{\"user\": { \"id\": 123,\"birthdate\": null, \"login\":\"marvin\"}}"];

	STAssertEqualStrings(@"marvin", [RestConfiguration username], nil);
	STAssertEqualStrings(@"sue's secret", [RestConfiguration password], nil);
}

-(void)testWhenNotCreatingNewOnAccountDetailsLodedUsernameAndPasswordNotSavedToRestConfiguration{
	account.username = @"marvin";
	account.password = @"sue's secret";
	
	[RestConfiguration setUsername:@"rita"];
	[RestConfiguration setPassword:@"rufus"];

	[account finishedLoading:@"{\"user\": { \"id\": 123},\"birthdate\": null}"];

	STAssertEqualStrings(@"rita", [RestConfiguration username], nil);
	STAssertEqualStrings(@"rufus", [RestConfiguration password], nil);
}


//TODO wallet


-(void)testPopulationFromRestDidFinishLoading{
	NSString *data = @"{\"user\": { \"birthdate\": \"1973-03-27\", \"id\": 123, \"gender\":\"M\", \"income\": \"25283\", \"email\": \"marvin@example.com\", \"login\": \"marvello\", \"wallet\" : {\"balance\" : 12.00}}}";

	[account finishedLoading:data];

	STAssertEquals(123, account.itemId, nil);
	STAssertEqualStrings(@"marvello", account.username,nil);
	STAssertEqualStrings(@"marvin@example.com", account.email, nil);
	STAssertEqualStrings(@"M", account.gender, nil);
	STAssertEquals(25283, account.income, nil);
	STAssertEqualStrings(@"27 Mar 1973", [DateHelper stringFromDate:account.birthdate], nil);
	STAssertEquals(1, accountChangeNotificationCount, @"accountChangeNotificationCount");
	STAssertEquals(accountLoadStatusLoaded, account.accountLoadStatus, @"accountLoadStatus");
	NSLog(@"%@",account.wallet);
	NSLog(@"%@", [[account.wallet objectForKey:@"balance"] class]);
	
	STAssertEqualObjects([NSDecimalNumber numberWithFloat:12.00f], [account.wallet objectForKey:@"balance"], @"walletbalance");
}

-(void)testPopulationWithErors{
	NSString* data = @"[[\"login\", \"is too short\"], [\"login\", \"should not be bob\"], [\"email\", \"should not be hotmail\"]]";

	[account finishedLoading:data];
	STAssertEquals(accountLoadStatusFailedValidation, account.accountLoadStatus, @"accountLoadStatus");
	STAssertEquals(2, (NSInteger) account.errors.count, @"error count");
	STAssertEqualStrings(@"is too short", [[account.errors valueForKey:@"login"] objectAtIndex:0], @"1st login error");
	STAssertEqualStrings(@"should not be bob", [[account.errors valueForKey:@"login"] objectAtIndex:1], @"2nd login error");
	STAssertEqualStrings(@"should not be hotmail", [[account.errors valueForKey:@"email"] objectAtIndex:0], @"1st login error");

}


-(void)testNullBirthdateDoesNoCauseErrors{
	NSString* data = @"{\"user\": { \"birthdate\":null}}";
	[account finishedLoading:data];
	STAssertNil(account.birthdate, nil);
}

-(void)testNullFieldsBecomeNil{
	NSString* data = @"{\"user\": { \"email\":null}}";
	[account finishedLoading:data];
	STAssertNil(account.email, nil);
	
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





-(void)testCreate{
	account.birthdate = [DateHelper dateFromString:@"15 Jul 1969"];
	account.email = @"bobby@bobo.net";
	account.username = @"bobby";
	account.password = @"pingupanga";
	account.passwordConfirmation = @"wrong";
	account.income = 12345;
	account.gender = @"F";

	[account createNew];
	STAssertNotNil(connectionRequest, @"connectionRequest");
	STAssertEqualStrings(@"http://localhost:3000/users.json", [[connectionRequest URL] relativeString], @"url");
	STAssertEqualStrings(@"POST", connectionRequest.HTTPMethod, @"http method");

	NSString* body = [connectionRequest httpBodyAsString];

	STAssertNotNil([body matchRegex:@"^{\"user\":{"], body);
	STAssertNotNil([body matchRegex:@"\"email\":\"bobby@bobo.net\""], body);
	STAssertNotNil([body matchRegex:@"\"login\":\"bobby\""], body);
	STAssertNotNil([body matchRegex:@"\"password\":\"pingupanga\""], body);
	STAssertNotNil([body matchRegex:@"\"password_confirmation\":\"wrong\""], body);
    STAssertNotNil([body matchRegex:@"\"birthdate\":\"1969-07-15\""], body);
	STAssertNotNil([body matchRegex:@"\"income\":12345"], body, nil);
	STAssertNotNil([body matchRegex:@"\"gender\":\"F\""], body);
}

-(void)testCreateWithNothingToSendDoesNotBlowUp{
	account.username = nil;
	account.password = nil;
	[account createNew];
	// Of course it fails validation, but that's not our concern here.
	STAssertEqualStrings(@"{\"user\":{\"income\":0}}", [connectionRequest httpBodyAsString], nil); 
}

-(void)testIsFemaleIsTrueIfAndOnlyIfGenderIsF{
	account.gender = @"F";
	STAssertTrue(account.isFemale, @"should be female");
	account.gender = @"M";
	STAssertFalse(account.isFemale, @"should not be female");
	account.gender = nil;
	STAssertFalse(account.isFemale, @"should not be female");
}



-(void)testProperlyInitialised{
	STAssertEquals(0, (NSInteger) account.errors.count, nil);
}

@end
