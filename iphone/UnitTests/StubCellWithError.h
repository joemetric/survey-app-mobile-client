#import "UIKit/UIKit.h"
#import "HasError.h"

@interface StubCellWithError : UITableViewCell<HasError>{
	NSString* errorField;
	BOOL errorHighlighted;
}

+(id)stubCellWithText:(NSString*)text errorField:(NSString*)errorField;

@end
