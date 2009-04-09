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
@synthesize pictureId;
@synthesize questionType;
@synthesize answerString;
@synthesize answerFile;
@synthesize localImageFile;

+ (id)newFromDictionary:(NSDictionary *)dict
{
    Answer *answer = [[Answer alloc] init];
    answer.itemId = [[dict objectForKey:@"id"] integerValue];
    answer.questionId = [[dict objectForKey:@"question_id"] integerValue];
    answer.pictureId = [[dict objectForKey:@"picture_id"] integerValue];
    answer.questionType = [dict objectForKey:@"question_type"];
    answer.answerString = [dict objectForKey:@"answer_string"];
    answer.answerFile = [dict objectForKey:@"answer_file"];
    return answer;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSNumber numberWithInt:self.questionId] forKey:@"question_id"];
    [parameters setObject:[NSNumber numberWithInt:self.pictureId] forKey:@"picture_id"];
    [parameters setObject:self.questionType forKey:@"question_type"];
    if (self.answerString)
        [parameters setObject:self.answerString forKey:@"answer_string"];
    if (self.answerFile)
        [parameters setObject:self.answerFile forKey:@"answer_file"];
    
    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:@"answer"];
    [parameters release];
    
    return [container autorelease];
}


- (BOOL)store {
    NSLog(@"Storing answer");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *answerDirectory = [documentsDirectory stringByAppendingPathComponent:@"answers"];
    NSString *answerFilePath = [answerDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.plist", self.questionId]];

    [[NSFileManager defaultManager] createDirectoryAtPath:answerDirectory attributes:nil];

    NSLog(@"Storing answer: %@", answerFilePath);
    
    [[self toDictionary] writeToFile:answerFilePath atomically:YES];
    
    return YES;
}

- (void)dealloc
{
    [questionType release];
    [answerFile release];
    [answerString release];
    [super dealloc];
}

@end
