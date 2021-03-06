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
    NSMutableArray  *questions;
    NSDate          *updatedAt;
    BOOL             complete;
}

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *amount;
@property (nonatomic, retain) NSMutableArray *questions;
@property (nonatomic, retain) NSDate *updatedAt;
@property (nonatomic, assign) BOOL complete;

+ (id)newFromDictionary:(NSDictionary *) dict;
+ (NSArray *)findAll;

- (NSString *)nameAndAmountAsString;
- (NSString *)amountAsDollarString;
- (BOOL) allQuestionsAnswered;
- (NSArray*) retrieveAnswers;
- (NSString*)localFilePath;

@end
