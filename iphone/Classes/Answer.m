//
//  Answer.m
//  JoeMetric
//
//  Created by Scott Barron on 3/10/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "Answer.h"


@implementation Answer

@synthesize itemId;
@synthesize questionId;
@synthesize questionType;

+ (id)newFromDictionary:(NSDictionary *)dict
{
    Answer *answer = [[Answer alloc] init];
    answer.itemId = [[dict objectForKey:@"id"] integerValue];
    answer.questionId = [[dict objectForKey:@"question_id"] integerValue];
    answer.questionType = [dict objectForKey:@"question_type"];
    return answer;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSNumber numberWithInt:self.questionId] forKey:@"question_id"];
    [parameters setObject:self.questionType forKey:@"question_type"];
          
    return [parameters autorelease];
}


- (BOOL)store {
    NSLog(@"Storing answer");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *answerDirectory = [documentsDirectory stringByAppendingPathComponent:@"answers"];
    NSString *answerFile = [answerDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.plist", self.questionId]];

    [[NSFileManager defaultManager] createDirectoryAtPath:answerDirectory attributes:nil];

    NSLog(@"Storing answer: %@", answerFile);
    
    [[self toDictionary] writeToFile:answerFile atomically:YES];
    
    return YES;
}

- (void)dealloc
{
    [questionType release];
    [super dealloc];
}

@end
