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
@synthesize pk, name, description, total_payout;
@synthesize questions;
@synthesize pricing;

- (id)initWithPk:(NSInteger)p Name:(NSString *)n Description:(NSString *)d Payout:(NSNumber *)tp {
	if (self = [super init]) {
		self.pk = p;
		self.name = n;
		self.description = d;
		self.total_payout = tp;
	}
	return self;
}

- (void) dealloc
{
	[name release];
	[description release];
	[total_payout release];
	[questions release];
	[pricing release];
	
	[super dealloc];
}

- (NSMutableArray *)questions {
	if (questions == nil) {
		NSError *error;
		self.questions = [RestRequest getQuestions:self Error:&error];
	}
	return questions;
}

- (NSString *)pricing {
	if (pricing == nil) {
		pricing = [NSString stringWithFormat:@"$%.2f", [total_payout floatValue]];
	}
	return pricing;
}

@end
