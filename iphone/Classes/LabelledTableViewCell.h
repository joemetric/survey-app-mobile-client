#import <UIKit/UIKit.h>
#import "Labelled.h"
#import "Editable.h"

@interface LabelledTableViewCell : UITableViewCell<Editable> {
	UILabel* label;
	UITextField* textField;
    NSString* errorField;
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UITextField* textField;
@property (nonatomic, retain) IBOutlet UILabel* label;

+(LabelledTableViewCell*)loadLabelledCell;
-(LabelledTableViewCell*)withLabelText:(NSString*)text;
-(LabelledTableViewCell*)withPlaceholder:(NSString*)text;
-(LabelledTableViewCell*)withErrorField:(NSString*)text;
-(LabelledTableViewCell*)makeSecure;
-(LabelledTableViewCell*)withoutCorrections;
-(LabelledTableViewCell*)makeEmail;
-(LabelledTableViewCell*)withKeyboardType:(UIKeyboardType)keyboardType;
@end
