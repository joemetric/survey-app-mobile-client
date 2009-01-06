//
//  Campaign.m
//  JoeMetric
//
//  Created by Jon Distad on 1/5/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "Campaign.h"


@implementation Campaign

@synthesize name = _name;
// Not synthesizing amount, instead we define a special setter and the getter below.

- (NSDecimalNumber *)amount {
	return _amount;
}

- (void)setAmount:(id)amount {
	[_amount release];
	
	if ([amount isKindOfClass:[NSString class]]) {
		_amount = [[NSDecimalNumber decimalNumberWithString:amount] retain];
	} else {
		_amount = [[amount copy] retain];
	}
}


@end
