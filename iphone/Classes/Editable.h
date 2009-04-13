#import "Labelled.h"

@protocol Editable<Labelled>


@property(nonatomic) BOOL errorHighlighted;
@property(nonatomic, retain) NSString* errorField;

@end