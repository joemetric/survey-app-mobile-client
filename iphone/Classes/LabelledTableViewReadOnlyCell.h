#import <UIKit/UIKit.h>


@interface LabelledTableViewReadOnlyCell : UITableViewCell {
	UILabel* label;
	UILabel* valueField;
}

@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet UILabel* valueField;
@end