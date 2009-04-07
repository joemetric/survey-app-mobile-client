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

- (void)changeInAccount:(Account*)account {
	if (account.isErrorStatus) tabBarController.selectedIndex = 2;
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [window addSubview:tabBarController.view];
	
	[self initializeSettings];
	currentAccount = [[Account alloc] init];
	[currentAccount loadCurrent];
	[currentAccount onChangeNotifyObserver:self];

    SurveyManager *sm = [[SurveyManager alloc] initWithObserver:self];
    [sm loadSurveysFromNetwork];
    [sm release];
}

- (void) initializeSettings {
	if ([[NSUserDefaults standardUserDefaults] stringForKey:@"username"] == nil)
	{
		// since no default values have been set (i.e. no preferences file created), create it here
		NSDictionary *appDefaults =  [NSDictionary dictionaryWithObjectsAndKeys:
									  @"", @"username",
									  @"", @"password",
                                      @"localhost", @"host",
                                      @"3000", @"port",
									  nil];
		[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
		[[NSUserDefaults standardUserDefaults] synchronize];
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

