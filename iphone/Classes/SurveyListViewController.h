#import <UIKit/UIKit.h>

@interface SurveyListViewController : UITableViewController {
    NSArray *surveys;
}

@property (nonatomic, retain) NSArray *surveys;

- (void)refreshSurveys;

@end
