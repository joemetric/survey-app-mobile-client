#import <UIKit/UIKit.h>
#import "Labelled.h"

@protocol Editable<Labelled>
@property(nonatomic) BOOL errorHighlighted;
@property(nonatomic, retain) NSString* errorField;

@optional
-(UITextField*)textField;
-(void)setTextField:(UITextField*)textField;

@end