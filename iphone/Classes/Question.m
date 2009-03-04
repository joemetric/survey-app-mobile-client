//
//  Question.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "Question.h"

@implementation Question

@synthesize text;
@synthesize amount;

+ (NSString *)resourceName
{
    return @"questions";
}

+ (NSString *)resourceKey
{
    return @"question";
}

+ (id)newFromDictionary:(NSDictionary *)dict
{
    Question *question = [[Question alloc] init];
    question.itemId       = [[[dict objectForKey:[self resourceKey]] objectForKey:@"id"] integerValue];
    question.text         = [[dict objectForKey:[self resourceKey]] objectForKey:@"text"];
    question.amount       = [[dict objectForKey:[self resourceKey]] objectForKey:@"amount"];
    question.questionType = [[dict objectForKey:[self resourceKey]] objectForKey:@"question_type"];
    return question;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:self.text forKey:@"text"];
    [parameters setObject:self.amount forKey:@"amount"];
    [parameters setObject:self.questionType forKey:@"question_type"];

    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:[[self class] resourceKey]];

    [parameters release];
    return [container autorelease];
}


- (NSString *)amountAsDollarString {
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setFormat:@"$#,##0.00"];
    return [numberFormatter stringFromNumber:self.amount];
}

- (NSString *)questionAndAmountAsString {
    return [NSString stringWithFormat:@"%@ : %@", [self amountAsDollarString], self.text];
}

- (void)dealloc {
    [text release];
    [amount release];
    [super dealloc];
}
    
@end
