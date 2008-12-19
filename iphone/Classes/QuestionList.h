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
    NSMutableArray *questions;
    Question *_currentQuestionObject;
    NSMutableString *_contentOfCurrentQuestionProperty;
}

@property (nonatomic, retain) Question *currentQuestionObject;
@property (nonatomic, retain) NSMutableString *contentOfCurrentQuestionProperty;

-(Question *)questionAtIndex:(NSUInteger)index;
-(NSUInteger)count;
-(void)refreshQuestionList;

@end