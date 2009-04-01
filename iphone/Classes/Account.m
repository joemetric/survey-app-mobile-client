//
//  Account.m
//  JoeMetric
//
//  Created by Scott Barron on 12/22/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "Account.h"
#import "Rest.h"
#import "JSON.h"
#import "JoeMetricAppDelegate.h"
#import "RestConfiguration.h"

NSDate* fromShortIso8601(NSString *shortDate){
	if ([NSNull null] == (id)shortDate || nil == shortDate) return  nil;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"yyyy-MM-dd";
	NSDate * result = [formatter dateFromString:shortDate];
	[formatter release];
	return result;
}

@interface Account()
-(void) changeLoadStatusTo:(AccountLoadStatus)status;
-(void) changeLoadStatusTo:(AccountLoadStatus)status withError:(NSError*)error;

@property(nonatomic, retain) id callbackObject;
@property(nonatomic) SEL callbackSelector; 

@end


@implementation Account

@synthesize username;
@synthesize password;
@synthesize email;
@synthesize gender;
@synthesize income;
@synthesize birthdate;
@synthesize callbackObject;
@synthesize callbackSelector;
@synthesize accountLoadStatus;
@synthesize lastLoadError;
@synthesize errors;

+ (NSString *)resourceName{
	return @"users";
}

+ (NSString *)resourceKey{
	return @"user";
}

-(BOOL)hasErrors {
	return self.errors != nil && self.errors.count > 0;
}

-(void)populateFromDictionary:(NSDictionary*)dict{
	NSDictionary *params = [dict objectForKey:@"user"];
	self.email = [params objectForKey:@"email"];
	self.gender = [params objectForKey:@"gender"];
	self.income = [[params objectForKey:@"income"] integerValue];
	self.birthdate = fromShortIso8601([params objectForKey:@"birthdate"]);
	self.itemId = [[params objectForKey:@"id"] integerValue];   
}



-(void)loadFromDictionary:(NSDictionary*)dict{
	[self populateFromDictionary:dict];
	[self changeLoadStatusTo: accountLoadStatusLoaded];

	[RestConfiguration setUsername:username];
	[RestConfiguration setPassword:password];

}

-(void)failedValidation:(NSArray*)array{
	NSMutableDictionary* newErrors = [NSMutableDictionary dictionary];
	for (NSArray* error in array){
		NSLog(@"\n%@", error);
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
    static const NSString* dictionaryClassName = @"NSCFDictionary";
	NSLog(@"data:%@", data);
	NSObject *unpackedJson = [data JSONFragmentValue];
	if (NSOrderedSame == [dictionaryClassName compare:[unpackedJson className]]){
		[self loadFromDictionary:(NSDictionary*)unpackedJson];
	}
	else{
		[self failedValidation:(NSArray*) unpackedJson];
	}
}



-(void)onChangeNotify:(SEL)callme on:(id)callMeObj{
	self.callbackSelector = callme;
	self.callbackObject = callMeObj;    
}

-(void)createNew{
	NSMutableDictionary* fields = [NSMutableDictionary dictionary];
	[fields setValue:self.email forKey:@"email"];
	[fields setValue:self.password forKey:@"password"];
	[fields setValue:self.password forKey:@"password_confirmation"];
	[fields setValue:[NSNumber numberWithInteger:self.income] forKey:@"income"];
	[fields setValue:self.gender forKey:@"gender"];
	[fields setValue:self.username forKey:@"login"];

	NSDictionary* container = [NSDictionary dictionaryWithObject:fields forKey:@"user"];

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



+ (id)newFromDictionary:(NSDictionary *) dict{
	Account *account = [[Account alloc] init];
	[account populateFromDictionary:dict];
	return account;
}


- (NSDictionary *)toDictionary
{
	NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:self.username forKey:@"name"];
	[parameters setObject:self.password forKey:@"password"];
	[parameters setObject:self.email forKey:@"email"];

	NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
	[container setObject:parameters forKey:[[self class] resourceKey]];

	[parameters release];
	return [container autorelease];
}

-(void) changeLoadStatusTo:(AccountLoadStatus)status{
	[self changeLoadStatusTo:status withError:nil];
}

-(void) changeLoadStatusTo:(AccountLoadStatus)status withError:(NSError*)error{
	accountLoadStatus = status;
	[callbackObject performSelector:callbackSelector withObject:self];
	self.lastLoadError = error;		
}


-(id) init{
	[super initWithPath:@""];
	self.errors = [[NSDictionary alloc] init];
	self.username = [RestConfiguration username];
	self.password = [RestConfiguration password];
	return self;
}


- (void) dealloc
{
	[username release];
	[password release];
	[errors release];
	[email release];
	[gender release];
	[birthdate release];
	self.callbackObject = nil;
	self.callbackSelector = nil;  
	self.lastLoadError = nil;
	[super dealloc];
}
@end
