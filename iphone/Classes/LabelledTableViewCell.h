#import <UIKit/UIKit.h>
#import "Labelled.h"
#import "HasError.h"

@interface LabelledTableViewCell : UITableViewCell <UITextFieldDelegate, Labelled, HasError> {
	UILabel* label;
	UITextField* textField;
	UITableView* tableView;
    NSString* errorField;
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UITextField* textField;
@property (nonatomic, retain) IBOutlet UILabel* label;

+(LabelledTableViewCell*) loadLabelledCellWithOwner:(id)owner;
-(LabelledTableViewCell*)withLabelText:(NSString*)text;

@end
