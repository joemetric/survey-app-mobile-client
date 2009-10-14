//
//  Survey.m
//  Survey
//
//  Created by Allerin on 09-10-13.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "Survey.h"
#import "RestRequest.h"


@implementation Survey
@synthesize pk, name, description;
@synthesize questions;

- (id)initWithPk:(NSInteger)p Name:(NSString *)n Description:(NSString *)d {
	if (self = [super init]) {
		self.pk = p;
		self.name = n;
		self.description = d;
	}
	return self;
}

- (void) dealloc
{
	[name release];
	[description release];
	[questions release];
	
	[super dealloc];
}

- (NSMutableArray *)questions {
	if (questions == nil) {
		NSError *error;
		self.questions = [RestRequest getQuestions:self Error:&error];
	}
	return questions;
}

@end
