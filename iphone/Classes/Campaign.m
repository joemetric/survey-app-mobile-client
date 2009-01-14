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

- (id)init {
    return [super init];
}

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

- (id)initWithName:(NSString *)name amount:(NSDecimalNumber *)amount {
    [super init];
    self.name = name;
    self.amount = amount;
    return self;
}

- (NSString *)amountAsDollarString {
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setFormat:@"$#,##0.00"];
    return [numberFormatter stringFromNumber:self.amount];
}

- (NSString *)campaignAndAmountAsString {
    return [NSString stringWithFormat:@"%@ : %@", [self amountAsDollarString], self.name];
}

- (void)dealloc {
    [self.name release];
    [self.amount release];
    [super dealloc];
}

@end

