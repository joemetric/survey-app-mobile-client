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
	self.username.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
	self.password.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
}

- (IBAction) login:(id)sender {
	self.errorLabel.text = @"";
	[self.activityIndicator startAnimating];

	NSString* hostString = [NSString stringWithFormat:@"localhost"];
	Rest* testRest = [[[Rest alloc] init] autorelease];
	testRest.delegate = self;
	[testRest GET:@"/surveys.json" withCallback:@selector(receivedTestData:)];
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
	
	[[NSUserDefaults standardUserDefaults] setObject:username.text forKey:@"username"];
	[[NSUserDefaults standardUserDefaults] setObject:password.text forKey:@"password"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
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
