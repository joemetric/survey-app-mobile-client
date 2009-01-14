//
//  Account.m
//  JoeMetric
//
//  Created by Scott Barron on 12/22/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "Account.h"


@implementation Account

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

@end
