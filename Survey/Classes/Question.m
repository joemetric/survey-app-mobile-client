//
//  Question.m
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "Question.h"
#import "Survey.h"
#import "Answer.h"


@implementation Question
@synthesize survey, pk, question_type, name, description, answer, complement, image; 

- (id)initWithSurvey:(Survey *)s PK:(NSInteger)p QuestionType:(NSString *)qt Name:(NSString *)n Description:(NSString *)desc {
	if (self = [super init]) {
		self.survey = s;
		self.pk = p;
		self.name = n;
		self.description = desc;
		
		if ([qt isEqualToString:@"Short Text Response"]) {
			self.question_type = ShortAnswer;
		} else if ([qt isEqualToString:@"Multiple Choice"]) {
			self.question_type = MultipleChoice;
		} else if ([qt isEqualToString:@"Photo Upload"]) {
			self.question_type = PhotoUpload;
		} else {
			self.question_type = UNKNOWN;
		}
	}
	return self;
}

- (void) dealloc
{
	[survey release];
	[name release];
	[description release];
	[answer release];
	[image release];
	
	[super dealloc];
}

- (BOOL)isShortAnswer {
	return question_type == ShortAnswer;
}

- (BOOL)isMultipleChoice {
	return question_type == MultipleChoice;
}

- (BOOL)isPhotoUpload {
	return question_type == PhotoUpload;
}

@end
