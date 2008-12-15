//
//  QuestionList.h
//  JoeMetric
//
//  Created by Joseph OBrien on 12/15/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"


// Right now this is just a wrapper object, but will be an entry 
// point for our xml parsing, etc...
@interface QuestionList : NSObject {
    NSArray *questions;
}

-(Question *)questionAtIndex:(NSUInteger)index;
-(NSUInteger)count;

@end
