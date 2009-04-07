#import "JoeMetricAppDelegate.h"
#import "Account.h"
#import "SurveyManager.h"
#import "SurveyListViewController.h"

@interface JoeMetricAppDelegate (Private)
- (void) initializeSettings;
@end


@implementation JoeMetricAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize currentAccount;

- (void)surveysStored {
    [surveyListView refreshSurveys];
}

-(void)ensureOnlyProfilePageSelectedIfAccountIsInErrorStatus{
	if (tabBarController.selectedIndex !=2 && [Account currentAccount].isErrorStatus)  tabBarController.selectedIndex = 2;
	
}

- (void)loadSurveys {
    if (![Account currentAccount].isErrorStatus) {
        SurveyManager *sm = [[SurveyManager alloc] initWithObserver:self];
        [sm loadSurveysFromNetwork];
        [sm release];
    }
}

- (void)changeInAccount:(Account*)account {
	[self ensureOnlyProfilePageSelectedIfAccountIsInErrorStatus];
    [self loadSurveys];
}

- (void)tabBarController:(UITabBarController *)_tabBarController didSelectViewController:(UIViewController *)viewController{
	[self ensureOnlyProfilePageSelectedIfAccountIsInErrorStatus];
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [window addSubview:tabBarController.view];
	
	currentAccount = [[Account alloc] init];
	[currentAccount loadCurrent];
	[currentAccount onChangeNotifyObserver:self];
}




- (void)dealloc {
	[currentAccount release];
    [navigationController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

