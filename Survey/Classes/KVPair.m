//
//  Income.m
//  Survey
//
//  Created by Allerin on 09-10-29.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "KVPair.h"


@implementation KVPair
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
