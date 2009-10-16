//
//  Answer.m
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "Answer.h"


@implementation Answer
@synthesize pk, question_id, answer;


- (void) dealloc
{
	[answer release];
	
	[super dealloc];
}


@end
