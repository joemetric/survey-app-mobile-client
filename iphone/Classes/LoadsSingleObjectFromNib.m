//
//  LoadsSingleObjectFromNib.m
//  JoeMetric
//
//  Created by Paul Wilson on 13/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import "LoadsSingleObjectFromNib.h"

@interface LoadsSingleObjectFromNib()
@property(nonatomic, readonly) id loadMe;
@end


@implementation LoadsSingleObjectFromNib
@synthesize loadMe;
+(id)loadFromNib:(NSString*)nibName{
    LoadsSingleObjectFromNib* loader = [[self alloc] init];
	[[NSBundle mainBundle] loadNibNamed:nibName owner:loader options:nil];
    id result = loader.loadMe;
    [loader release];
    return result;
}
@end
