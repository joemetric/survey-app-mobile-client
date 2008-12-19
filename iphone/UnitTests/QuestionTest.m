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
  Question *question = [[Question alloc] initWithText:@"" amount:[NSDecimalNumber zero]];
    
  STAssertEqualStrings(@"$0.00", [question amountAsDollarString], @"zero format");
}

- (void) testAmountAsDollarStringWithNonZero
{
  Question *question = [[Question alloc] initWithText:@"" amount:[NSDecimalNumber decimalNumberWithString:@"1925.32"]];
    
  STAssertEqualStrings(@"$1,925.32", [question amountAsDollarString], @"non-zero format");
}
@end
