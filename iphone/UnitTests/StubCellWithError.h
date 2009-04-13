#import "UIKit/UIKit.h"
#import "Editable.h"

@interface StubCellWithError : UITableViewCell<Editable>{
	NSString* errorField;
	BOOL errorHighlighted;
}

+(id)stubCellWithText:(NSString*)text errorField:(NSString*)errorField;

@end
