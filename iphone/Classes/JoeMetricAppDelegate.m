#import "JoeMetricAppDelegate.h"
#import "Account.h"
#import "SurveyManager.h"
#import "SurveyListViewController.h"
#import "RestConfiguration.h"

@interface JoeMetricAppDelegate (Private)
- (void) initializeSettings;
@end


@implementation JoeMetricAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize currentAccount;

- (void)surveysStored {
	NSLog(@"surveysStored");
	NSLog(@"slv: %@", surveyListView);
    [surveyListView refreshLocalSurveys];
}

-(void)ensureOnlyProfilePageSelectedIfAccountIsInErrorStatus{
	if (tabBarController.selectedIndex !=2 && [Account currentAccount].isErrorStatus)  tabBarController.selectedIndex = 2;
	
}

- (void)loadSurveys {
	NSLog(@"loadSurveys");
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

    if ([[RestConfiguration username] isEqualToString:@""] || [[RestConfiguration password] isEqualToString:@""]) {
        tabBarController.selectedIndex = 2;
    }
}




- (void)dealloc {
	[currentAccount release];
    [navigationController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

