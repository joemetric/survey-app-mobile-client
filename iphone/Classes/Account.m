#import "Account.h"
#import "JSON.h"
#import "JoeMetricAppDelegate.h"
#import "RestConfiguration.h"
#import "NSDictionary+RemoveNulls.h"


@interface Account()
-(void) changeLoadStatusTo:(AccountLoadStatus)status;
-(void) changeLoadStatusTo:(AccountLoadStatus)status withError:(NSError*)error;

@property(nonatomic, retain) NSMutableArray* observers;

@end


@implementation Account

@synthesize username;
@synthesize password;
@synthesize email;
@synthesize gender;
@synthesize income;
@synthesize birthdate;
@synthesize wallet;
@synthesize accountLoadStatus;
@synthesize lastLoadError;
@synthesize errors;
@synthesize passwordConfirmation;
@synthesize itemId;
@synthesize observers;


-(NSDateFormatter*)iso8061DateFormatter{
	NSDateFormatter* result = [[[NSDateFormatter alloc] init] autorelease];
	result.dateFormat = @"yyyy-MM-dd";
	return result;
}

-(NSString*)iso8061BirthDate{
	NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
	formatter.dateFormat = @"yyyy-MM-dd";
	return [self.iso8061DateFormatter stringFromDate:self.birthdate];
}

-(void)setIso8061BirthDate:(NSString*)iso8061Date{
	if (nil == iso8061Date) {
		self.birthdate = nil;
	}
	else {
		self.birthdate = [self.iso8061DateFormatter dateFromString:iso8061Date];
	}
}

- (NSDecimalNumber*) walletBalance {
	return (NSDecimalNumber*)[self.wallet objectForKey:@"balance"];
}

- (NSInteger) walletTransactionCount {
	return [[self.wallet objectForKey:@"wallet_transactions"] count];
}

-(void)loadFromDictionary:(NSDictionary*)dict{
	NSDictionary *params = [[dict objectForKey:@"user"] withoutNulls];
	self.email = [params objectForKey:@"email"];
	self.gender = [params objectForKey:@"gender"];
	self.income = [[params objectForKey:@"income"] integerValue];
	self.iso8061BirthDate=[params objectForKey:@"birthdate"];
	self.itemId = [[params objectForKey:@"id"] integerValue];   
	self.username = [params objectForKey:@"login"];
	self.wallet = [params objectForKey:@"wallet"];

	if(accountLoadStatusCreatingNew == accountLoadStatus){
		[RestConfiguration setUsername:username];
		[RestConfiguration setPassword:password];
	}

	[self changeLoadStatusTo: accountLoadStatusLoaded];
}

-(void)failedValidation:(NSArray*)array{
	NSMutableDictionary* newErrors = [NSMutableDictionary dictionary];
	for (NSArray* error in array){
		NSString* field = [error objectAtIndex:0];
		NSMutableArray* fieldErrors = [newErrors valueForKey:field];
		if (nil ==  fieldErrors){
			fieldErrors = [NSMutableArray array];
			[newErrors setValue:fieldErrors forKey:field];
		}
		[fieldErrors addObject:[error objectAtIndex:1]];
	}	
	self.errors = newErrors;
	[self changeLoadStatusTo:accountLoadStatusFailedValidation];
}

- (void)finishedLoading:(NSString *)data{
	NSObject *unpackedJson = [data JSONFragmentValue];
	if ([unpackedJson isKindOfClass:[NSDictionary class]]){
		[self loadFromDictionary:(NSDictionary*)unpackedJson];
	}
	else{
		[self failedValidation:(NSArray*) unpackedJson];
	}
}

-(BOOL)isFemale{
 	return [((NSString*)@"F") compare:gender] == NSOrderedSame;
}




-(void)onChangeNotifyObserver:(id<AccountObserver>)observer{
	[observers addObject:observer];
}

-(void)noLongerNotifyObserver:(id<AccountObserver>)observer{
	[observers removeObject:observer];
}


-(void)createNew{
	NSMutableDictionary* fields = [NSMutableDictionary dictionary];
	[fields setValue:self.email forKey:@"email"];
	[fields setValue:self.password forKey:@"password"];
	[fields setValue:self.passwordConfirmation forKey:@"password_confirmation"];
	[fields setValue:[NSNumber numberWithInteger:self.income] forKey:@"income"];
	[fields setValue:self.gender forKey:@"gender"];
	[fields setValue:self.username forKey:@"login"];
	[fields setValue:self.iso8061BirthDate forKey:@"birthdate"];

	NSDictionary* container = [NSDictionary dictionaryWithObject:fields forKey:@"user"];

	[self changeLoadStatusTo:accountLoadStatusCreatingNew];
	[[RestfulRequests restfulRequestsWithObserver:self] POST:@"/users.json" withParams:container];
}

+(Account*) currentAccount{
	return ((JoeMetricAppDelegate*)[UIApplication sharedApplication].delegate).currentAccount;
}

-(void)loadCurrent{
	[[RestfulRequests restfulRequestsWithObserver:self] GET:@"/users/current.json"];
}

-(void)authenticationFailed{
	[self changeLoadStatusTo:accountLoadStatusUnauthorized];
}

- (void)failedWithError:(NSError *)error{
	[self changeLoadStatusTo:accountLoadStatusLoadFailed withError:error];
}


-(void) changeLoadStatusTo:(AccountLoadStatus)status{
	[self changeLoadStatusTo:status withError:nil];
}

-(void) changeLoadStatusTo:(AccountLoadStatus)status withError:(NSError*)error{
	accountLoadStatus = status;
	for (id<AccountObserver> observer in observers) [observer changeInAccount:self];
	self.lastLoadError = error;		
}

-(BOOL) isErrorStatus{
	switch(accountLoadStatus){
	case accountLoadStatusUnauthorized:
	case accountLoadStatusLoadFailed:
		return YES;
	default:
		return NO;
	}
}



-(id) init{
	[super init];
	self.errors = [[NSDictionary alloc] init];
	self.username = [RestConfiguration username];
	self.password = [RestConfiguration password];
	self.observers = [NSMutableArray array];
	return self;
}


- (void) dealloc{
	[username release];
	[password release];
	[errors release];
	[email release];
	[gender release];
	[birthdate release];
	self.observers = nil;
	[super dealloc];
}
@end
