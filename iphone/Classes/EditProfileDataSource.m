//
//  EditProfileDataSource.m
//  JoeMetric
//
//  Created by Paul Wilson on 15/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import "EditProfileDataSource.h"
#import "TableSection.h"

@implementation EditProfileDataSource

-(id)init{
    [super init];
    
    
    [self addSection:[TableSection tableSectionWithTitle:@"Editing"]];
    return self;
}

@end
