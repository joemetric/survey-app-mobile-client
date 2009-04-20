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
#import "Answer.h"

@implementation Survey

@synthesize itemId;
@synthesize name;
@synthesize amount;
@synthesize questions;
@synthesize updatedAt;
@synthesize complete;

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
    
	NSArray* fromDisk = [SurveyManager loadSurveysFromLocal];
	NSLog(@"fromDisk.count = %d", fromDisk.count);
    for (id surveyDict in fromDisk) {
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

- (NSString*)localFilePath { 
	return [[SurveyManager surveyDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.plist", self.itemId]];
}


- (BOOL) allQuestionsAnswered {
	for( Question* q in self.questions ) {
		if( [Answer answerExistsForQuestion:q] == NO )
			return NO;
	}
	return YES;
}

- (NSArray*) retrieveAnswers {
	NSMutableArray* result = [NSMutableArray array];
	for( Question* q in self.questions ) {
		if( [Answer answerExistsForQuestion:q] == YES )
			[result addObject:[Answer answerForQuestion:q]];
	}
	return result;
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

