#import "StubEditable.h"

@implementation StubEditable
@synthesize errorField, errorHighlighted, label;

+(id)stubCellWithText:(NSString*)text errorField:(NSString*)errorField{
	StubEditable* result = [[[StubEditable alloc] init] autorelease];
	result.text = text;
	result.errorField = errorField;
	return result;
}

@end
