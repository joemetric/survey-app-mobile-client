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
@synthesize credentials;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    tabBarController.selectedIndex = 2;
    [actionSheet release];
}

- (void)authenticationFailed {
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.delegate = self;
    menu.title = @"Authentication Failed";
    [menu addButtonWithTitle:@"Create Account"];
    [menu addButtonWithTitle:@"Update Credentials"];
    [menu addButtonWithTitle:@"Cancel"];
    menu.cancelButtonIndex = 2;

    [menu showInView:[window contentView]];
}

- (void) initCredentialsFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    credentialsFilePath = [documentsDirectory stringByAppendingPathComponent:@"authprefs.plist"];
    [credentialsFilePath retain];
}

- (void)loadCredentials {
    if (credentialsFilePath == nil)
        [self initCredentialsFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: credentialsFilePath]) {
        credentials = [[NSMutableDictionary alloc]
                          initWithContentsOfFile:credentialsFilePath];
    } else {
        credentials = [[NSMutableDictionary alloc] initWithCapacity: 2];
        [credentials setObject:@"" forKey:@"username"];
        [credentials setObject:@"" forKey:@"password"];
    }
}

- (void)saveCredentials {
    [credentials writeToFile:credentialsFilePath atomically:YES];
}

- (NSURLCredential *)getCredentials {
    if (credentials == nil)
        [self loadCredentials];
    
    return [NSURLCredential credentialWithUser:[credentials objectForKey:@"username"]
                            password:[credentials objectForKey:@"password"]
                            persistence:NSURLCredentialPersistenceForSession];
}

- (void)dealloc {
    [navigationController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

