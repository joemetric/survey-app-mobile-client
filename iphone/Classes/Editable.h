#import <UIKit/UIKit.h>
#import "Labelled.h"

@protocol Editable<Labelled>
@property(nonatomic) BOOL errorHighlighted;
@property(nonatomic, retain) NSString* errorField;
-(void)activateEditing;


@optional
-(UITextField*)textField;
-(void)setTextField:(UITextField*)textField;

@end

@interface UITableViewCell(IsEditable)
-(BOOL)isEditableWithTextField;
-(BOOL)isMyEditableTextField:(UITextField*)textField;
-(void)ifEditableActivateEditing;
@end
