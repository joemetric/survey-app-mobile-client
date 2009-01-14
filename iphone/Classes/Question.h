//
//  Question.h
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//


@interface Question : NSObject {
    NSString *_text;
    NSDecimalNumber *_amount;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSDecimalNumber *amount;

- (id)initWithText:(NSString *)text amount:(id)amount;
- (NSString *)questionAndAmountAsString;
- (NSString *)amountAsDollarString;

@end
