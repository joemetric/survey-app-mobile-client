#import <UIKit/UIKit.h>
#import "Labelled.h"
#import "HasErrorCell.h"

@interface LabelledTableViewCell : UITableViewCell <UITextFieldDelegate, Labelled, HasErrorCell> {
	UILabel* label;
	UITextField* textField;
	UITableView* tableView;
    NSString* errorField;
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UITextField* textField;

@end
