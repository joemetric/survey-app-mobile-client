//
//  Survey.h
//  JoeMetric
//
//  Created by Jon Distad on 1/5/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

@interface Survey : NSObject {
    NSInteger        itemId;
    NSString        *name;
    NSDecimalNumber *amount;
}

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *amount;

+ (id)newFromDictionary:(NSDictionary *) dict;
+ (NSArray *)findAll;

- (NSString *)nameAndAmountAsString;
- (NSString *)amountAsDollarString;

@end
