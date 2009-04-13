#import "StubCellWithError.h"

@implementation StubCellWithError
@synthesize errorField, errorHighlighted, label;

+(id)stubCellWithText:(NSString*)text errorField:(NSString*)errorField{
	StubCellWithError* result = [[[StubCellWithError alloc] init] autorelease];
	result.text = text;
	result.errorField = errorField;
	return result;
}

@end
