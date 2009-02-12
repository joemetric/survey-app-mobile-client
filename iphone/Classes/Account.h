//
//  Account.h
//  JoeMetric
//
//  Created by Scott Barron on 12/22/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

// Create
// Authenticate

// has the account been created?
// YES:
//   authenticate with credentials
// NO:
//   enter credentials and create account

#import "Resource.h"

@interface Account : Resource {
    NSString *username;
    NSString *password;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

- (BOOL) isCreated;
// - (BOOL) credentialFileExists;
- (void) createCredentialFile;
- (NSString*) credentialFilePath;

@end
