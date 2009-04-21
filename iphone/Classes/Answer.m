//
//  Answer.m
//  JoeMetric
//
//  Created by Scott Barron on 3/10/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "Answer.h"
#import "Question.h"


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

+ (void)clearAllStored {
	NSLog(@"clearing stored answers");
	NSString* answersDir = [Answer answerDirectory];
	if( [[NSFileManager defaultManager] fileExistsAtPath:answersDir] ) {
		NSArray* answerFiles = [[NSFileManager defaultManager] directoryContentsAtPath:answersDir];
		
		for( NSString* answerFile in answerFiles ) {
			NSString* fullPath = [answersDir stringByAppendingPathComponent:answerFile];
			NSLog(@"clearing answer: %@", fullPath);
			[[NSFileManager defaultManager] removeItemAtPath:fullPath error:NULL];
		}
	}
}

+ (Answer*) answerForQuestion:(Question*) question {
	if( [Answer	answerExistsForQuestion:question] == NO )
		return nil;
	NSLog(@"retrieving answer");
	NSString* filepath = [Answer answerFilePathForQuestionId:question.itemId];
	NSLog(@"retrieve: filepath: %@", filepath);
	NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:filepath];
	NSLog(@"retrieve: dic: %@", dic);
	Answer* result = [Answer newFromDictionary:[dic objectForKey:@"answer"]];
	NSLog(@"retrieve: ans: %@", result);
	return [result autorelease];
}

+ (BOOL)answerExistsForQuestion:(Question*) question {
	NSString* filepath = [Answer answerFilePathForQuestionId:question.itemId];
	NSLog(@"checking if %@ exists", filepath);
	return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}

+ (NSString*) answerFilePathForQuestionId:(NSInteger)questionId {
	return [[Answer answerDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.plist", questionId]];
}

+ (NSString*) imageFilePathForQuestionId:(NSInteger)questionId {
	return [[Answer answerDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_image.png", questionId]];
}

+ (void) deleteAnswerForQuestion:(Question*)question {
	[[NSFileManager defaultManager] removeItemAtPath:[Answer answerFilePathForQuestionId:question.itemId] error:NULL];
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
    if (self.localImageFile)
		[parameters setObject:self.localImageFile forKey:@"local_image_file"];
    
    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    [container setObject:parameters forKey:@"answer"];
    [parameters release];
    
    return [container autorelease];
}

- (NSString*)localImageFile {
	return [Answer imageFilePathForQuestionId:self.questionId];
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


- (NSString*) answerFilePath{
    return [Answer answerFilePathForQuestionId:self.questionId];
}


+ (NSString*) answerDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *answerDirectory = [documentsDirectory stringByAppendingPathComponent:@"answers"];	
    [[NSFileManager defaultManager] createDirectoryAtPath:answerDirectory attributes:nil];
	return answerDirectory;
}

- (void)dealloc
{
    [questionType release];
    [answerFile release];
    [answerString release];
    [super dealloc];
}

@end
