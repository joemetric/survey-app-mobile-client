#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SurveyInfoViewTableCell : UITableViewCell {
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *textLabel;
}
@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UILabel* textLabel;

@end
