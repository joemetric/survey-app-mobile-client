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
    [window addSubview:tabBarController.view];
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex != 2) {
//        tabBarController.selectedIndex = 2;
//    }
//    [actionSheet release];
//}

- (void)authenticationFailed {
	tabBarController.selectedIndex = 2;
//    if (!authAlertMenu) {
//        authAlertMenu = [[UIActionSheet alloc] init];
//        authAlertMenu.delegate = self;
//        authAlertMenu.title = @"Authentication Failed";
//        [authAlertMenu addButtonWithTitle:@"Create Account"];
//        [authAlertMenu addButtonWithTitle:@"Update Credentials"];
//        [authAlertMenu addButtonWithTitle:@"Cancel"];
//        authAlertMenu.cancelButtonIndex = 2;
//    }
//
//    [authAlertMenu showInView:[tabBarController view]];
    // CLANG reports menu as leaking, but it isn't.  It's released above.
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
                            persistence:NSURLCredentialPersistenceNone];
}

- (void)dealloc {
    [navigationController release];
    [tabBarController release];
    [window release];
    [credentials release];
    [authAlertMenu release];
    [super dealloc];
}

@end

