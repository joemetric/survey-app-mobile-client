
#import "StubbedTextField.h"


@implementation StubbedTextField
- (BOOL)becomeFirstResponder{
	return isFirstResponder = YES;
}

- (BOOL)isFirstResponder{
	return isFirstResponder;
}
- (BOOL)resignFirstResponder{
	isFirstResponder = NO;
	return YES;
}


@end
