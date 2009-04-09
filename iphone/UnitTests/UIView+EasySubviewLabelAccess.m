#import <UIKit/UIKit.h>
#import "UIView+EasySubviewLabelAccess.h"


@implementation UIView(EasySubviewLabelAccess)



-(NSString*) labelTextAtIndex:(NSInteger)index{
	if (self.subviews.count <= index) return nil;
	return [[self.subviews objectAtIndex:index] text];
}

-(NSString*) labelText{
    return [self labelTextAtIndex:0];
}


@end
