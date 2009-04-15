
#import "StubbedTextView.h"


@implementation StubbedTextView
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
