#import <UIKit/UIKit.h>
#import "LabelledCell.h"

@interface LabelledTableViewReadOnlyCell : UITableViewCell<LabelledCell> {
	UILabel* label;
	UILabel* valueField;
}

@property (nonatomic, retain) IBOutlet UILabel* valueField;
@end