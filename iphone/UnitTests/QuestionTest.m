//
//  QuestionTest.m
//  JoeMetric
//
//  Created by Scott Barron on 12/19/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "QuestionTest.h"




@implementation QuestionTest

- (void) testAmountAsDollarStringWithZero
{
    Question *question = [[[Question alloc] init] autorelease];
    question.amount = [NSDecimalNumber zero];
    
    STAssertEqualStrings(@"$0.00", [question amountAsDollarString], @"zero format");
}

- (void) testAmountAsDollarStringWithNonZero
{
    Question *question = [[[Question alloc] init] autorelease];
    question.amount = [NSDecimalNumber decimalNumberWithString:@"1925.32"];
    
    STAssertEqualStrings(@"$1,925.32", [question amountAsDollarString], @"non-zero format");
}

- (void) testQuestionAndAmountAsString
{
    Question *question = [[[Question alloc] init] autorelease];
    question.name = @"A question?";
    question.text = @"Some explanatory text";
    question.amount = [NSDecimalNumber decimalNumberWithString:@"1925.32"];
    
    STAssertEqualStrings(@"$1,925.32 : A question?", [question questionAndAmountAsString], @"question and amount");
}
@end
