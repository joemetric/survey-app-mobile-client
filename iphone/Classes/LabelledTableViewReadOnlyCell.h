#import <UIKit/UIKit.h>
#import "Labelled.h"

@interface LabelledTableViewReadOnlyCell : UITableViewCell<Labelled> {
	UILabel* label;
	UILabel* valueField;
}

@property (nonatomic, retain) IBOutlet UILabel* valueField;
@end