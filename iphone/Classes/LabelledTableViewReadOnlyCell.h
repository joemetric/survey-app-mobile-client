#import <UIKit/UIKit.h>
#import "Labelled.h"

@interface LabelledTableViewReadOnlyCell : UITableViewCell<Labelled> {
	IBOutlet UILabel* label;
	IBOutlet UILabel* valueField;
}



@property (nonatomic, retain)  UILabel* valueField;
@end