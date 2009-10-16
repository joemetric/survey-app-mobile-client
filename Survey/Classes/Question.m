//
//  Question.m
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "Question.h"
#import "Survey.h"


@implementation Question
@synthesize survey, pk, question_type_id, name, description; 

- (id)initWithSurvey:(Survey *)s PK:(NSInteger)p QuestionTypeId:(NSInteger)qti Name:(NSString *)n Description:(NSString *)desc {
	if (self = [super init]) {
		self.survey = s;
		self.pk = p;
		self.question_type_id = qti;
		self.name = n;
		self.description = desc;
	}
	return self;
}

- (void) dealloc
{
	[survey release];
	[name release];
	[description release];
	
	[super dealloc];
}

@end
