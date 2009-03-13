//
//  CredentialsViewController.m
//  JoeMetric
//
//  Created by Alan Francis on 13/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "CredentialsViewController.h"
#import "JoeMetricAppDelegate.h"
#import "Rest.h"

@interface CredentialsViewController (Private)
- (void) clearCredentials;
- (void) dummyCallback:(NSData*)testData;
@end

@implementation CredentialsViewController
@synthesize username, password, profileView, errorLabel, activityIndicator;

- (void) viewDidAppear:(BOOL)animated {
	[self clearCredentials];
}

- (IBAction) login:(id)sender {
	self.errorLabel.text = @"";
	[self.activityIndicator startAnimating];

	Rest* testRest = [[[Rest alloc] initWithHost:@"localhost" atPort:3000] autorelease];
	testRest.delegate = self;
	[testRest GET:@"/surveys.json" withCallback:@selector(receivedTestData:)];
}

- (void) clearCredentials {
	NSDictionary* creds = [[NSURLCredentialStorage sharedCredentialStorage] allCredentials];
	for( NSURLProtectionSpace* key in creds ) {
		NSDictionary* credDictionary = [creds objectForKey:key];
		NSArray* credValues = [credDictionary allValues];
		
		for( NSURLCredential* cred in credValues ) {
			[[NSURLCredentialStorage sharedCredentialStorage] removeCredential:cred	forProtectionSpace:key];
		}
	}
	Rest* testRest = [[[Rest alloc] initWithHost:@"localhost" atPort:3000] autorelease];
	testRest.delegate = self;
	[testRest GET:@"/sessions/new" withCallback:@selector(dummyCallback:)];
	
}

- (NSURLCredential *)getCredentials {
	NSLog(@"getCredentials");
    return [NSURLCredential credentialWithUser:self.username.text
									  password:self.password.text
								   persistence:NSURLCredentialPersistenceNone];	
}

- (void)authenticationFailed {
	NSLog(@"authenticationFailed");
	self.errorLabel.text = @"Invalid login details";
	[self.activityIndicator stopAnimating];
}

- (void) dummyCallback:(NSData*)testData {
	NSLog(@"dummyCallback: %@", [[[NSString alloc] initWithBytes:testData.bytes length:testData.length encoding:NSUTF8StringEncoding] autorelease]);
}

- (void) receivedTestData:(NSData*)testData {
	NSLog(@"receivedTestData: %@", [[[NSString alloc] initWithBytes:testData.bytes length:testData.length encoding:NSUTF8StringEncoding] autorelease]);
	
	NSMutableDictionary* newCredentials = [NSMutableDictionary dictionary];
	[newCredentials setObject:username.text forKey:@"username"];
	[newCredentials setObject:password.text forKey:@"password"];
	
	JoeMetricAppDelegate* appDelegate = (JoeMetricAppDelegate*)[UIApplication sharedApplication].delegate;
	appDelegate.credentials = newCredentials;
	[appDelegate saveCredentials];
	
	self.errorLabel.text = @"";
	[self.activityIndicator stopAnimating];
	[self.profileView dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel:(id)sender {
	[self.profileView dismissModalViewControllerAnimated:YES];
}


- (void)dealloc {
	[username dealloc];
	[password dealloc];
    [super dealloc];
}


@end
