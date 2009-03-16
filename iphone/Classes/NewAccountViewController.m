//
//  NewAccountViewController.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "NewAccountViewController.h"
#import "Account.h"


@implementation NewAccountViewController
@synthesize username, password, emailAddress, activityIndicator, errorLabel, profileView;

- (void)dealloc {
    [super dealloc];
}

- (IBAction) signup {
	[self.activityIndicator startAnimating];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username.text forKey:@"login"];
    [params setObject:emailAddress.text forKey:@"email"];
    [params setObject:password.text forKey:@"password"];
    [params setObject:password.text forKey:@"password_confirmation"];
    Account *account = [Account createWithParams:params];
	[self.activityIndicator stopAnimating];
    if (account) {
		[[NSUserDefaults standardUserDefaults] setObject:username.text forKey:@"username"];
		[[NSUserDefaults standardUserDefaults] setObject:password.text forKey:@"password"];
		[self.profileView dismissModalViewControllerAnimated:YES];
    } else {
		UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Account Creation Failed" message:@"We were unable to create an account with those details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];
    }	
}

- (IBAction) cancel {
	[self.profileView dismissModalViewControllerAnimated:YES];
}


@end
