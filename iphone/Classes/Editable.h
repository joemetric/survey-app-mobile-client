#import <UIKit/UIKit.h>
#import "Labelled.h"

@protocol Editable<Labelled>
@property(nonatomic) BOOL errorHighlighted;
@property(nonatomic, retain) NSString* errorField;

@optional
@property(nonatomic, assign)id<UITextFieldDelegate> textFieldDelegate;

@end