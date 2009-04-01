#import "GTMSenTestCase.h"
#import "Account.h"
#import "Rest.h"
#import "RestStubbing.h"
#import "NSString+Regex.h"
#import "RestConfiguration.h"



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

-(void)testUsernameAndPasswordTakenFromRestConfiguration{
	[RestConfiguration setUsername:@"rita"];
	[RestConfiguration setPassword:@"my little secret"];

	self.account = [[[Account alloc] init] autorelease];

	STAssertEqualStrings(@"rita", account.username, nil);
	STAssertEqualStrings(@"my little secret", account.password, nil);
}


-(void)testOnAccountDetailsLodedUsernameAndPasswordSavedToRestConfiguration{
	account.username = @"marvin";
	account.password = @"sue's secret";
	
	[account finishedLoading:@"{\"user\": { \"id\": 123},\"birthdate\": null}"];
	
	STAssertEqualStrings(@"marvin", [RestConfiguration username], nil);
	STAssertEqualStrings(@"sue's secret", [RestConfiguration password], nil);
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

-(void)testPopulationWithErors{
	NSString* data = @"[[\"login\", \"is too short (minimum is 3 characters)\"], [\"email\", \"should look like an email address.\"]]";

	[account finishedLoading:data];
	STAssertEquals(accountLoadStatusFailedValidation, account.accountLoadStatus, @"accountLoadStatus");
	
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
	NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"rita@sue.com", @"456",  nil] forKeys:[NSArray arrayWithObjects:@"email", @"id", nil]];
	NSDictionary *user = [NSDictionary dictionaryWithObject:params forKey:@"user"];
	self.account = [[Account newFromDictionary:user] autorelease];
	STAssertEquals(456, account.itemId, nil);
	STAssertEqualStrings(@"rita@sue.com", account.email, nil);

}


-(void)testCreate{
    account.birthdate = [dateFormatter dateFromString:@"15 July 1969"];
    account.email = @"bobby@bobo.net";
    account.username = @"bobby";
    account.password = @"pingupanga";
    account.income = 12345;
    account.gender = @"F";
    
    [account createNew];
	STAssertNotNil(connectionRequest, @"connectionRequest");
	STAssertEqualStrings(@"http://localhost:3000/users.json", [[connectionRequest URL] relativeString], @"url");
	STAssertEqualStrings(@"POST", connectionRequest.HTTPMethod, @"http method");
    
    NSData* data = [connectionRequest HTTPBody];
	
	NSString* body = [connectionRequest httpBodyAsString];
  
    STAssertNotNil([body matchRegex:@"^{\"user\":{"], body);
    STAssertNotNil([body matchRegex:@"\"email\":\"bobby@bobo.net\""], body);
    STAssertNotNil([body matchRegex:@"\"login\":\"bobby\""], body);
    STAssertNotNil([body matchRegex:@"\"password\":\"pingupanga\""], body);
    STAssertNotNil([body matchRegex:@"\"password_confirmation\":\"pingupanga\""], body);

    STAssertNotNil([body matchRegex:@"\"income\":12345"], body, nil);
    STAssertNotNil([body matchRegex:@"\"gender\":\"F\""], body);
}


-(void)testProperlyInitialised{
	STAssertEquals(0, (NSInteger) account.errors.count, nil);
	STAssertNotNil(account.rest, nil);
}

@end
