//
//  JoeMetricAppDelegate.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright EdgeCase, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Account;
@interface JoeMetricAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UIActionSheetDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    UINavigationController *navigationController;
	Account* currentAccount;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, readonly) Account* currentAccount;

- (void)authenticationFailed;

@end
