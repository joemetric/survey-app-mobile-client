#import <UIKit/UIKit.h>

@interface SurveyListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    NSArray *surveys;
	UITableView* tableView;
	UILabel* cashLabel;
}

- (IBAction)  refreshSurveys;

@property (nonatomic, retain) NSArray *surveys;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *cashLabel;

@end
