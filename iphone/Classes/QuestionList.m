//
//  QuestionList.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/15/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "QuestionList.h"
#import "Question.h"


@implementation QuestionList

- (id)init {
    if (self = [super init]) { 
        questions = [NSMutableArray arrayWithObjects:
                          [[Question alloc] initWithText:@"What kind of detergent do you use" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:.50]],
                          [[Question alloc] initWithText:@"What is you favorite color" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:4.50]],
                          [[Question alloc] initWithText:@"Take a picture of your closet"
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:3.75]],
                          [[Question alloc] initWithText:@"How do you feel today" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:2.00]], 
                          [[Question alloc] initWithText:@"Some really really long question that goes on and on and on" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:10.00]], 
                          nil];
        [questions retain];
    }
    return self;
}

-(Question *)questionAtIndex:(NSUInteger)index {
    return [questions objectAtIndex:index];
}

-(NSUInteger)count {
    return [questions count];
}

-(void)refreshQuestionList {
    [questions addObject:[[Question alloc] initWithText:[NSString stringWithFormat:@"NewQuestion: %d", [self count]]
                                                 amount:[[NSDecimalNumber alloc] initWithDouble:1.00]]];
}

- (void)dealloc {
    [questions release];
    [super dealloc];
}

@end
