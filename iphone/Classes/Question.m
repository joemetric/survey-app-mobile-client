//
//  Question.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "Question.h"

@implementation Question

@synthesize itemId;
@synthesize name;
@synthesize text;
@synthesize amount;
@synthesize questionType;

+ (id)questionFromDictionary:(NSDictionary *)dict
{
    Question *question = [[Question alloc] init];
    question.itemId       = [[dict objectForKey:@"id"] integerValue];
    question.name         = [dict objectForKey:@"name"];
    question.text      = [dict objectForKey:@"text"];
    question.amount       = [dict objectForKey:@"amount"];
    question.questionType = [dict objectForKey:@"question_type"];
    return [question autorelease];
}


- (NSString *)amountAsDollarString {
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setCurrencySymbol:@"$"];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [numberFormatter stringFromNumber:self.amount];
}

- (NSString *)questionAndAmountAsString {
    return [NSString stringWithFormat:@"%@ : %@", [self amountAsDollarString], self.name];
}

- (void)dealloc {
    [text release];
    [amount release];
    [questionType release];
    [super dealloc];
}
    
@end
