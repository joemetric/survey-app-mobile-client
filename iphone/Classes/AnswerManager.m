//
//  AnswerManager.m
//  JoeMetric
//
//  Created by Scott Barron on 4/8/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "AnswerManager.h"
#import "Survey.h"
#import "Answer.h"
#import "RestConfiguration.h"

@interface AnswerManager (Private)
- (void)push;
- (void)pushBasicAnswer;
- (void)pushPictureAnswer;
@end

@implementation AnswerManager

@synthesize answer;

+ (void)submitCompleteSurvey:(Survey*) survey {
	if( [survey allQuestionsAnswered] ) {
		NSArray* answers = [survey retrieveAnswers];
		for( Answer* answer in answers ) {
			[AnswerManager pushAnswer:answer];
		}
		[AnswerManager postCompletion:survey];
	}
	
}

+ (void)pushAnswer:(Answer *)answer {
    NSLog(@"Pushing answer to server %@", answer.questionType);
    AnswerManager *manager = [[AnswerManager alloc] initWithAnswer:answer];
    [manager push];
    [manager release];
}

- (void)push {
    if ([answer.questionType isEqualToString:@"picture"]) {
        [self pushPictureAnswer];
    } else {
        [self pushBasicAnswer];
    }
}

- (void)pictureUploaded:(NSString *)data {
    answer.pictureId = [data integerValue];
    NSLog(@"Picture has been uploaded: %@", data);
    [self pushBasicAnswer];
}

- (void)pushPictureAnswer {
    NSLog(@"Pushing picture");
    PictureUploader *uploader = [[PictureUploader alloc] initWithImage:answer.localImageFile andObserver:self];
    [uploader upload];
	[uploader release];
}

- (void)pushBasicAnswer {
    // push answer to server
    NSLog(@"Pushing basics");
    [[RestfulRequests restfulRequestsWithObserver:self] POST:@"/answers.json" withParams:[answer toDictionary]];
}

+ (void) postCompletion:(Survey*)survey {
	NSDictionary* completion = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:survey.itemId] forKey:@"survey_id"] forKey:@"completion"];
    AnswerManager *manager = [[AnswerManager alloc] init];
    [[RestfulRequests restfulRequestsWithObserver:manager] POST:@"/completions.json" withParams:completion];	
    [manager release];
}

+ (void) removeAnswersForSurvey:(Survey*)survey {
	for( Question* q in survey.questions ) {
		if( [Answer answerExistsForQuestion:q] ) {
			[Answer deleteAnswerForQuestion:q];
		}
	}
}

-(void) authenticationFailed {
    
}

-(void) failedWithError:(NSError *)error {
    
}

-(void) finishedLoading:(NSString *)data {
}

- (id)initWithAnswer:(Answer *)anAnswer {
    if (self = [super init]) {
        self.answer = anAnswer;
    }
    return self;
}
@end
