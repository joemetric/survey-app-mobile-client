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


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [navigationController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

