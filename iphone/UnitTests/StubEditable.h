#import "UIKit/UIKit.h"
#import "Editable.h"

@interface StubEditable : UITableViewCell<Editable>{
	NSString* errorField;
	BOOL errorHighlighted;
    UILabel* label;
	BOOL activated;
}

+(id)stubCellWithText:(NSString*)text errorField:(NSString*)errorField;
@property(nonatomic, retain) UILabel* label;
@property(nonatomic, assign) BOOL activated;
@end


@interface StubEditableWithTextField : StubEditable{
	UITextField* textField;
}
@property(nonatomic, assign) UITextField* textField;


+(id)stubEditableWithTextField;
@end