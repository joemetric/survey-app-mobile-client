#import "UIKit/UIKit.h"
#import "Editable.h"

@interface StubCellWithError : UITableViewCell<Editable>{
	NSString* errorField;
	BOOL errorHighlighted;
    UILabel* label;
}

+(id)stubCellWithText:(NSString*)text errorField:(NSString*)errorField;
@property(nonatomic, retain) UILabel* label;
@end
