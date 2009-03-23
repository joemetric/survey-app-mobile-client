//
//  JoeMetricAppDelegate.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright EdgeCase, LLC 2008. All rights reserved.
//

#import "JoeMetricAppDelegate.h"

@interface JoeMetricAppDelegate (Private)
- (void) initializeSettings;
@end


@implementation JoeMetricAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [window addSubview:tabBarController.view];
	
	[self initializeSettings];
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
    [navigationController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

