//
//  Question.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "Question.h"


@implementation Question

@synthesize text = _text;
@synthesize amount = _amount;

- (id)init {
    return [super init];
}

- (NSDecimalNumber *)amount {
	return _amount;
}

- (void)setAmount:(id)amount {
	[_amount release];
	
	if ([amount isKindOfClass:[NSString class]]) {
		_amount = [NSDecimalNumber decimalNumberWithString:amount];
	} else {
		_amount = [amount copy];
	}
}

- (id)initWithText:(NSString *)text amount:(NSDecimalNumber *)amount {
    [super init];
    self.text = text;
    self.amount = amount;
    return self;
}

- (NSString *)amountAsDollarString {
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setFormat:@"$#,##0.00"];
    return [numberFormatter stringFromNumber:self.amount];
}

- (NSString *)questionAndAmountAsString {
    return [NSString stringWithFormat:@"%@ | %@", [self amountAsDollarString] , self.text];
}

- (void)dealloc {
    [self.text release];
    [self.amount release];
    [super dealloc];
}
    
@end
