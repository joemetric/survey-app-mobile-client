//
//  Answer.m
//  JoeMetric
//
//  Created by Scott Barron on 3/10/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "Answer.h"


@implementation Answer

@synthesize questionId;
@synthesize questionType;

+ (NSString *)resourceName
{
    return @"answers";
}

+ (NSString *)resourceKey
{
    return @"answer";
}

+ (id)newFromDictionary:(NSDictionary *)dict
{
    Answer *answer = [[Answer alloc] init];
    answer.itemId = [[[dict objectForKey:[self resourceKey]] objectForKey:@"id"] integerValue];
    answer.questionId = [[[dict objectForKey:[self resourceKey]] objectForKey:@"question_id"] integerValue];
    answer.questionType = [[dict objectForKey:[self resourceKey]] objectForKey:@"question_type"];
    return answer;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSNumber numberWithInt:self.questionId] forKey:@"question_id"];
    [parameters setObject:self.questionType forKey:@"question_type"];

    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:[[self class] resourceKey]];

    [parameters release];
    return [container autorelease];
}

- (void)dealloc
{
    [questionType release];
    [super dealloc];
}

@end
