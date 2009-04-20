#import <UIKit/UIKit.h>
@class JoeMetricAppDelegate;

@interface SurveyListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    NSArray *surveys;
	UITableView* tableView;
	UILabel* cashLabel;
	JoeMetricAppDelegate *jmAppDelegate;
}

- (IBAction)  refreshSurveys;
- (void) refreshLocalSurveys;

@property (nonatomic, retain) NSArray *surveys;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *cashLabel;
@property (nonatomic, retain) IBOutlet JoeMetricAppDelegate *jmAppDelegate;

@end
