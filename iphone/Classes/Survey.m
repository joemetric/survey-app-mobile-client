//
//  Survey.m
//  JoeMetric
//
//  Created by Jon Distad on 1/5/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "Survey.h"
#import "Question.h"
#import "SurveyManager.h"

@implementation Survey

@synthesize itemId;
@synthesize name;
@synthesize amount;
@synthesize questions;
@synthesize updatedAt;

+ (id)newFromDictionary:(NSDictionary *) dict
{
    Survey *survey   = [[Survey alloc] init];
    survey.itemId    = [[dict objectForKey:@"id"] integerValue];
    survey.name      = [dict objectForKey:@"name"];
    survey.amount    = [dict objectForKey:@"amount"];
    survey.updatedAt = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"updated_at"] intValue]];
    
    for (id question in [dict objectForKey:@"questions"]) {
        [survey.questions addObject:[Question newFromDictionary:question]];
    }
    
    return survey;
}

+ (NSArray *)findAll {
    NSMutableArray *surveys = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id surveyDict in [SurveyManager loadSurveysFromLocal]) {
        Survey *survey = [self newFromDictionary:surveyDict];
        [surveys addObject:survey];
        [survey release];
    }
    
    return [surveys autorelease];
}

- (NSString *)amountAsDollarString
{
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setCurrencySymbol:@"$"];
    return [numberFormatter stringFromNumber:self.amount];
}

- (NSString *)nameAndAmountAsString
{
    return [NSString stringWithFormat:@"%@ : %@", [self amountAsDollarString], self.name];
}

- (id)init {
    if (self = [super init]) {
        self.questions = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)dealloc {
    [name release];
    [amount release];
    [questions release];
    [updatedAt release];
    [super dealloc];
}

@end

