#import <UIKit/UIKit.h>
#import "Labelled.h"
#import "Editable.h"

@interface LabelledTableViewCell : UITableViewCell <UITextFieldDelegate, Labelled, Editable> {
	UILabel* label;
	UITextField* textField;
	UITableView* tableView;
    NSString* errorField;
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UITextField* textField;
@property (nonatomic, retain) IBOutlet UILabel* label;

+(LabelledTableViewCell*) loadLabelledCell;
-(LabelledTableViewCell*)withLabelText:(NSString*)text;

@end
