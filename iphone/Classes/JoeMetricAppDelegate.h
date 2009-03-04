//
//  JoeMetricAppDelegate.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright EdgeCase, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoeMetricAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    UINavigationController *navigationController;
    NSString *credentialsFilePath;
    NSMutableDictionary *credentials;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableDictionary *credentials;
@end
