//
//  JoeMetricAppDelegate.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright EdgeCase, LLC 2008. All rights reserved.
//

#import "JoeMetricAppDelegate.h"
#import "Account.h"

@interface JoeMetricAppDelegate (Private)
- (void) initializeSettings;
@end


@implementation JoeMetricAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize currentAccount;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [window addSubview:tabBarController.view];
	
	[self initializeSettings];
	currentAccount = [[Account alloc] initWithPath:@"/users/user"];
	[currentAccount loadCurrent];
}

- (void) initializeSettings {
	if ([[NSUserDefaults standardUserDefaults] stringForKey:@"username"] == nil)
	{
		// since no default values have been set (i.e. no preferences file created), create it here
		NSDictionary *appDefaults =  [NSDictionary dictionaryWithObjectsAndKeys:
									  @"", @"username",
									  @"", @"password",
									  nil];
		[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (void)authenticationFailed {
	tabBarController.selectedIndex = 2;
}


- (void)dealloc {
	[currentAccount release];
    [navigationController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

