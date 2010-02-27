//
//  SurveyAppDelegate.m
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright Allerin 2009. All rights reserved.
//

#import "SurveyAppDelegate.h"
#import "BrowseController.h"
#import "WalletController.h"
#import "ProfileController.h"
#import "SettingsController.h"
#import "LoginController.h"
#import "Metadata.h"
#import "RestRequest.h"
#import "UserRestRequest.h"
#import "User.h"


@implementation SurveyAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize browseController, walletController, profileController, settingsController;
@synthesize loginController;
@synthesize metadata;
@synthesize logined;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	[window addSubview:tabBarController.view];

	logined = FALSE;
	if ((self.metadata = [Metadata getMetadata]) == nil) {
		self.tabBarController.selectedIndex = 2;
		[profileController.navigationController presentModalViewController:self.loginController animated:YES];
	} else {
		[self performSelectorInBackground:@selector(tryLogin:) withObject:self.metadata.user];
	}
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {

    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
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


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Survey.sqlite"]];
	NSLog([storeUrl description]);
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark View Controller

- (LoginController *)loginController {
	if (loginController == nil) {
		LoginController *lc = [[LoginController alloc] initWithNibName:@"LoginView" bundle:nil];
		self.loginController = lc;
		[lc release];
	}
	return loginController;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
	[window release];
	[tabBarController release];
	
	[browseController release];
	[walletController release];
	[profileController release];
	[settingsController release];
	[loginController release];
	
	[super dealloc];
}

- (void)tryLogin:(User *)user {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSError *error;
	if (![RestRequest loginWithUser:user.login Password:user.password Error:&error]) {
		[self performSelectorOnMainThread:@selector(failLogin:) withObject:error waitUntilDone:YES];
	} else {
		logined = TRUE;
	}
	
	[pool drain];
}

- (void)failLogin:(NSError *)error {
	self.tabBarController.selectedIndex = 2;
	[profileController.navigationController presentModalViewController:self.loginController animated:YES];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
													message:[error localizedDescription]
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end

