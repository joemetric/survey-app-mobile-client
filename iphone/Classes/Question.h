//
//  Question.h
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "Resource.h"

@interface Question : Resource {
    NSString        *text;
    NSDecimalNumber *amount;
    NSString        *questionType;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSDecimalNumber *amount;
@property (nonatomic, retain) NSString *questionType;

- (NSString *)questionAndAmountAsString;
- (NSString *)amountAsDollarString;

@end
