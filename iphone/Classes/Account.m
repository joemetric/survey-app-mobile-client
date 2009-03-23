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

+ (NSString *)resourceName{
	return @"users";
}

+ (NSString *)resourceKey{
	return @"user";
}


-(void)populateFromDictionary:(NSDictionary*)dict{
	NSDictionary *params = [dict objectForKey:@"user"];
	self.username = [params objectForKey:@"login"];
	self.email = [params objectForKey:@"email"];
	self.gender = [params objectForKey:@"gender"];
	self.income = [[params objectForKey:@"income"] integerValue];
	self.birthdate = fromShortIso8601([params objectForKey:@"birthdate"]);
	self.itemId = [[params objectForKey:@"id"] integerValue];   

}

- (void)populateFromReceivedData:(NSData *)data{
	NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"populateFromReceivedData: '%@'", str);
	NSDictionary *dict = (NSDictionary *)[str JSONFragmentValue];
	[str release];
	[self populateFromDictionary:dict];
	[self changeLoadStatusTo: accountLoadStatusLoaded];
}


-(void)onChangeNotify:(SEL)callme on:(id)callMeObj{
	self.callbackSelector = callme;
	self.callbackObject = callMeObj;    
}


+(Account*) currentAccount{
	return ((JoeMetricAppDelegate*)[UIApplication sharedApplication].delegate).currentAccount;
}

-(void)loadCurrent{
	[self.rest GET:@"/users/current.json" withCallback:@selector(populateFromReceivedData:)];
}

-(void)authenticationFailed{
	[self changeLoadStatusTo:accountLoadStatusUnauthorized];
}

- (void)rest:(Rest *)rest didFailWithError:(NSError *)error{
	[self changeLoadStatusTo:accountLoadStatusLoadFailed withError:error];
}



+ (id)newFromDictionary:(NSDictionary *) dict
{
	Account *account = [[[Account alloc] init] retain];
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


- (void) dealloc
{
	[username release];
	[password release];
	[email release];
	[gender release];
	[birthdate release];
	self.callbackObject = nil;
	self.callbackSelector = nil;  
	self.lastLoadError = nil;
	[super dealloc];
}
@end
