//
//  Account.m
//  JoeMetric
//
//  Created by Scott Barron on 12/22/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "Account.h"


@implementation Account

@synthesize username;
@synthesize password;
@synthesize email;

+ (NSString *)resourceName
{
    return @"users";
}

+ (NSString *)resourceKey
{
    return @"user";
}

+ (id)newFromDictionary:(NSDictionary *) dict
{
    Account *account = [[Account alloc] init];
    account.itemId   = [[[dict objectForKey:[self resourceKey]] objectForKey:@"id"] integerValue];
    account.username = [[dict objectForKey:[self resourceKey]] objectForKey:@"username"];
    account.password = [[dict objectForKey:[self resourceKey]] objectForKey:@"password"];
    account.email = [[dict objectForKey:[self resourceKey]] objectForKey:@"email"];
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
    [super dealloc];
}
@end
