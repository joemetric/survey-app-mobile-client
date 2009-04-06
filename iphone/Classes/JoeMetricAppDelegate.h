#import <UIKit/UIKit.h>
#import "SurveyManager.h"

@class Account;
@class SurveyListViewController;

@interface JoeMetricAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UIActionSheetDelegate, SurveyManagerObserver> {
    UIWindow *window;
    UITabBarController *tabBarController;
    UINavigationController *navigationController;
	Account* currentAccount;
    IBOutlet SurveyListViewController *surveyListView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, readonly) Account* currentAccount;

- (void)authenticationFailed;

@end
