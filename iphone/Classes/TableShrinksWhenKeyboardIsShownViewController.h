

#import <UIKit/UIKit.h>


@interface TableShrinksWhenKeyboardIsShownViewController : UIViewController {
	UITableView* tableView;
	BOOL keyboardIsShowing;

}
-(NSInteger) tableShrinkingKeyboardHeightCorrection;

@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic) BOOL keyboardIsShowing;

@end
