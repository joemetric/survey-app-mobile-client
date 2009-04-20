#import <UIKit/UIKit.h>
 

@interface StubbedTextField : UITextField{
	BOOL isFirstResponder;
}

- (BOOL)becomeFirstResponder;
- (BOOL)isFirstResponder;
- (BOOL)resignFirstResponder;

@end
