#import "GTMSenTestCase.h"
#import "Account.h"



@interface AccountTest : GTMTestCase{
	NSDateFormatter *dateFormatter;
	Account *account;
	NSInteger accountChangeNotificationCount;
}
@property(nonatomic, retain) Account* account;
@end

NSData* fromAsciiString(NSString *string){
	return [string dataUsingEncoding:NSASCIIStringEncoding];
}

@implementation AccountTest
@synthesize account;

-(void)accountChanged:(Account*)_account{
	STAssertEquals(account, _account, nil);
	accountChangeNotificationCount++;
}

- (void)setUp{
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"dd MMM yyyy";
	self.account = [[[Account alloc] initWithPath:@"/users/user"] autorelease];
	[account onChangeNotify:@selector(accountChanged:) on:self];
	accountChangeNotificationCount = 0;

}

- (void)tearDown{
	[dateFormatter release];
	self.account = nil;
}

-(void)testPopulationFromData{
	NSData *data = fromAsciiString(@"{\"user\": { \"birthdate\": \"1973-03-27\", \"id\": 123, \"gender\":\"M\", \"login\": \"marvin\", \"income\": \"25283\", \"email\": \"marvin@example.com\"}}");

	[account populateFromReceivedData:data];

	STAssertEquals(123, account.itemId, nil);
	STAssertEqualStrings(@"marvin", account.username,nil);
	STAssertEqualStrings(@"marvin@example.com", account.email, nil);
	STAssertEqualStrings(@"M", account.gender, nil);
	STAssertEquals(25283, account.income, nil);
	STAssertEqualStrings(@"27 Mar 1973", [dateFormatter stringFromDate:account.birthdate], nil);
	STAssertEquals(1, accountChangeNotificationCount, @"accountChangeNotificationCount");
	STAssertEquals(accountLoadStatusLoaded, account.accountLoadStatus, @"accountLoadStatus");
}

-(void)testPopulationWithMostlyEmptyData{
	NSData *data = fromAsciiString(@"{\"user\": { \"id\": 123},\"birthdate\": null}");
	[account populateFromReceivedData:data];
	STAssertEquals(123, account.itemId, nil);

}

-(void)testNewFromDictionaryWith_NSNull_Birthdate{
	NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"456", [NSNull null],  nil] forKeys:[NSArray arrayWithObjects:@"id", @"birthdate", nil]];
	NSDictionary *user = [NSDictionary dictionaryWithObject:params forKey:@"user"];
	self.account = [Account newFromDictionary:user];
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
	[account rest:nil didFailWithError:error];
	STAssertEquals(accountLoadStatusLoadFailed, account.accountLoadStatus, @"accountLoadStatus");
	STAssertEquals(1, accountChangeNotificationCount, @"accountChangeNotificationCount");
	STAssertEqualStrings(error, account.lastLoadError, @"lastLoadError");
}



-(void)testNewFromDictionary{
	NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"rita", @"456",  nil] forKeys:[NSArray arrayWithObjects:@"login", @"id", nil]];
	NSDictionary *user = [NSDictionary dictionaryWithObject:params forKey:@"user"];
	self.account = [Account newFromDictionary:user];
	STAssertEquals(456, account.itemId, nil);
	STAssertEqualStrings(@"rita", account.username, nil);

}

-(void)testErrorsInitiallyEmpty{
	STAssertEquals(0, (NSInteger) account.errors.count, nil);
}

@end
