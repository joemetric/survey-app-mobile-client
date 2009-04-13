#import "StubEditable.h"

@implementation StubEditable
@synthesize errorField, errorHighlighted, label;

+(id)stubCellWithText:(NSString*)text errorField:(NSString*)errorField{
	StubEditable* result = [[[self alloc] init] autorelease];
	result.text = text;
	result.errorField = errorField;
	return result;
}

@end

@implementation StubEditableWithTextField
@synthesize  textField;
+(id)stubEditableWithTextField{
	StubEditableWithTextField* result =  [[[self alloc] init] autorelease];
	result.textField = [[[UITextField alloc] init] autorelease];
	return result;
}

@end
