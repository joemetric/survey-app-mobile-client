//
//  SurveyAppDelegate.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright Allerin 2009. All rights reserved.
//

@class BrowseController, WalletController, ProfileController, SettingsController;
@class LoginController, Metadata;

@interface SurveyAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
	UITabBarController *tabBarController;
	
	BrowseController *browseController;
	WalletController *walletController;
	ProfileController *profileController;
	SettingsController *settingsController;
	LoginController *loginController;
	
	Metadata *metadata;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet BrowseController *browseController;
@property (nonatomic, retain) IBOutlet WalletController *walletController;
@property (nonatomic, retain) IBOutlet ProfileController *profileController;
@property (nonatomic, retain) IBOutlet SettingsController *settingsController;
@property (nonatomic, retain) IBOutlet LoginController *loginController;

@property (nonatomic, retain) Metadata *metadata;

- (NSString *)applicationDocumentsDirectory;

@end

