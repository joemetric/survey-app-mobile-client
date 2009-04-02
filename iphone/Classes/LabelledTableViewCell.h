#import <UIKit/UIKit.h>
#import "LabelledCell.h"

@interface LabelledTableViewCell : UITableViewCell <UITextFieldDelegate, LabelledCell> {
	UILabel* label;
	UITextField* textField;
	UITableView* tableView;
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UITextField* textField;

@end
