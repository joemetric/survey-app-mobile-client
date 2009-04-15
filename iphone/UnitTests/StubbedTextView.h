#import <UIKit/UIKit.h>
 

@interface StubbedTextView : UITextView{
	BOOL isFirstResponder;
}

- (BOOL)becomeFirstResponder;
- (BOOL)isFirstResponder;
- (BOOL)resignFirstResponder;

@end
