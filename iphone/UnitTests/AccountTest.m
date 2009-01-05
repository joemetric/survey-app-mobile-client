//
//  AccountTest.m
//  JoeMetric
//
//  Created by Scott Barron on 12/22/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "AccountTest.h"


@implementation AccountTest

- (void) testIsNotCreatedIfCredentailsAreMissing
{
    [self removeCredentialFile];

    Account *account = [[Account alloc] init];
    
    STAssertEquals(NO, [account isCreated], nil);
}

- (void) testIsCreatedIfCredentialsArePresent
{
    [self createCredentialFile];

    Account *account = [[Account alloc] init];
    STAssertTrue([account isCreated], nil);
}

- (void) testCredentialFilePath
{
    Account *account = [[Account alloc] init];
    STAssertEqualStrings([self credentialFilePath], [account credentialFilePath], nil);
}

- (void) testCreateCredentialFile
{
    [self removeCredentialFile];
    
    Account *account = [[Account alloc] init];
    [account createCredentialFile];

    STAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[self credentialFilePath]], nil);
}



- (void) createCredentialFile
{
    NSString *documentFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *credentialFile = [documentFolderPath stringByAppendingPathComponent:@"credentials.txt"];
    
    [[NSFileManager defaultManager] createFileAtPath:credentialFile contents:nil attributes:nil];
}

 

- (void) removeCredentialFile {
    [[NSFileManager defaultManager] removeItemAtPath:[self credentialFilePath] error:nil];
}

- (NSString*)credentialFilePath
{
    NSString *documentFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *credentialFile = [documentFolderPath stringByAppendingPathComponent:@"credentials.txt"];
    
    return credentialFile;
}

@end
