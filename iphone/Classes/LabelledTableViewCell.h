#import <UIKit/UIKit.h>
#import "Labelled.h"

@interface LabelledTableViewCell : UITableViewCell <UITextFieldDelegate, Labelled> {
	UILabel* label;
	UITextField* textField;
	UITableView* tableView;
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UITextField* textField;

@end
