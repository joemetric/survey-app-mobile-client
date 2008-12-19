//
//  QuestionTest.m
//  JoeMetric
//
//  Created by Scott Barron on 12/19/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "QuestionTest.h"


@implementation QuestionTest

- (void) testAmountAsDollarStringWithZero
{
  NSDecimalNumber *zero;
  zero = [NSDecimalNumber zero];

  Question *question = [[Question alloc] initWithText:@"" amount:zero];
    
  STAssertEqualStrings(@"$0.00", [question amountAsDollarString], @"zero format");
}

@end
