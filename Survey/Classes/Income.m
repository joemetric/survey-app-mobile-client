//
//  Income.m
//  Survey
//
//  Created by Ye Dingding on 09-10-29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Income.h"


@implementation Income
@synthesize pk, desc;

- (id)initWithPk:(NSNumber *)p Desc:(NSString *)d {
	if (self = [super init]) {
		self.pk = p;
		self.desc = d;
	}
	return self;
}

- (void) dealloc
{
	[pk release];
	[desc release];
	
	[super dealloc];
}


@end
