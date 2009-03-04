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
    return account;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:self.username forKey:@"name"];
    [parameters setObject:self.password forKey:@"password"];

    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:[[self class] resourceKey]];

    [parameters release];
    return [container autorelease];
}

- (BOOL) isCreated
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self credentialFilePath]];
}

- (void) createCredentialFile
{
    [[NSFileManager defaultManager] createFileAtPath:[self credentialFilePath] contents:nil attributes:nil];
}

- (NSString*) credentialFilePath
{
    NSString *documentFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *credentialFile = [documentFolderPath stringByAppendingPathComponent:@"credentials.txt"];
    return credentialFile;
}

- (void) dealloc
{
    [username release];
    [password release];
    [super dealloc];
}
@end
