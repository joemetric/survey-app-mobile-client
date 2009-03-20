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

NSDate* fromShortIso8601(NSString *shortDate){
	if ([NSNull null] == (id)shortDate || nil == shortDate) return  nil;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"yyyy-MM-dd";
	NSDate * result = [formatter dateFromString:shortDate];
	[formatter release];
	return result;
}

@interface Account()
@property(nonatomic, retain) id callMeBackOnLoadDelegate;
@property(nonatomic) SEL callMeBackOnLoadSelector; 

@end


@implementation Account

@synthesize username;
@synthesize password;
@synthesize email;
@synthesize gender;
@synthesize income;
@synthesize birthdate;
@synthesize callMeBackOnLoadSelector;
@synthesize callMeBackOnLoadDelegate;
@synthesize accountLoadStatus;

+ (NSString *)resourceName
{
	return @"users";
}

+ (NSString *)resourceKey
{
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
    NSLog(@"%@", str);
	NSDictionary *dict = (NSDictionary *)[str JSONFragmentValue];
	[str release];
	[self populateFromDictionary:dict];
	[callMeBackOnLoadDelegate performSelector:callMeBackOnLoadSelector withObject:self];
	self.callMeBackOnLoadDelegate = nil;
	self.callMeBackOnLoadSelector = nil;  
}

+(Account*) currentAccountWithCallback:(SEL)callme on:(id)delegate{
	Account *result = [[[Account alloc] initWithPath:@"/users/user"] autorelease];
	result.callMeBackOnLoadSelector = callme;
	result.callMeBackOnLoadDelegate = delegate;    
	[result.rest GET:@"/users/current" withCallback:@selector(populateFromReceivedData:)];
    return result;
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



- (void) dealloc
{
	[username release];
	[password release];
	[email release];
	[gender release];
	[birthdate release];
	self.callMeBackOnLoadDelegate = nil;
	self.callMeBackOnLoadSelector = nil;  
	[super dealloc];
}
@end
