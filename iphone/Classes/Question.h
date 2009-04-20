//
//  Question.h
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

@interface Question : NSObject {
    NSInteger        itemId;
    NSString        *name;
    NSString        *text;
    NSDecimalNumber *amount;
    NSString        *questionType;
}

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSDecimalNumber *amount;
@property (nonatomic, retain) NSString *questionType;

+ (id)questionFromDictionary:(NSDictionary *)dict;

- (NSString *)questionAndAmountAsString;
- (NSString *)amountAsDollarString;

@end
