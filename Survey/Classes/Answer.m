//
//  Answer.m
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "Answer.h"
#import "Question.h"


@implementation Answer
@synthesize pk, question, answer;

- (id)initWithPK:(NSInteger)p Question:(Question *)ques Answer:(NSString *)ans {
	if (self = [super init]) {
		self.pk = p;
		self.question = ques;
		self.answer = ans;
	}
	return self;
}

- (void) dealloc
{
	[answer release];
	[question release];
	
	[super dealloc];
}


@end
