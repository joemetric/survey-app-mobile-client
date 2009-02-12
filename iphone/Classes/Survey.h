//
//  Survey.h
//  JoeMetric
//
//  Created by Jon Distad on 1/5/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "Resource.h"

@interface Survey : Resource {
    NSString        *name;
    NSDecimalNumber *amount;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *amount;

- (NSArray *)questions;
- (NSString *)nameAndAmountAsString;
- (NSString *)amountAsDollarString;

@end
