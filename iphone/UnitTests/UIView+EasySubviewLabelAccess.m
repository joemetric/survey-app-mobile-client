#import <UIKit/UIKit.h>
#import "UIView+EasySubviewLabelAccess.h"


@implementation UIView(EasySubviewLabelAccess)
-(NSString*) labelTextAtIndex:(NSInteger*)index{
	if (index >= self.subviews.count) return nil;
	return [[self.subviews objectAtIndex:index] text];
}

-(NSString*) labelText{
	if(self.subviews.count == 0) return nil;
	return [[self.subviews objectAtIndex:0] text];
}


@end
