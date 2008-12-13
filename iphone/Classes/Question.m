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

// Questions should not be initialized directly
- (id)init {
    NSAssert( false, @"Questions should be initialized with initWithText:text:amount." );
    [self autorelease];
    return nil;
}

- (id)initWithText:(NSString *)text amount:(NSDecimalNumber *)amount {
    if (self = [super init]) {
        self.text = text;
        self.amount = amount;
        // Custom initialization
    }
    return self;
}

- (NSString *)questionAndAmountAsString {
    return [NSString stringWithFormat:@"$%@ | %@", self.amount, self.text];
}



@end
