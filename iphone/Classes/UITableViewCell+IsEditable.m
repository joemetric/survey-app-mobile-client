
#import "Editable.h"


@implementation UITableViewCell(IsEditable)
-(BOOL)isEditableWithTextField{
	return [self conformsToProtocol:@protocol(Editable)] && [self respondsToSelector:@selector(textField)];
}

-(BOOL)isMyEditableTextField:(UITextField*)textField{
	if (![self isEditableWithTextField]) return NO;
	return [(id<Editable>) self textField] == textField;
}

@end
