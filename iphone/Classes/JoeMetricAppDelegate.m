//
//  JoeMetricAppDelegate.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright EdgeCase, LLC 2008. All rights reserved.
//

#import "JoeMetricAppDelegate.h"


@implementation JoeMetricAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}

- (NSURLCredential *)getCredentials {
    // Looks up credential information
    return [NSURLCredential credentialWithUser:@"quentin"
                            password:@"monkey"
                            persistence:NSURLCredentialPersistenceForSession];
}

- (void)dealloc {
    [navigationController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

