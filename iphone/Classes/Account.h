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

@interface Account : NSObject {

}

- (BOOL) isCreated;
- (BOOL) credentialFileExists;
- (void) createCredentialFile;
- (NSString*) credentialFilePath;

@end
