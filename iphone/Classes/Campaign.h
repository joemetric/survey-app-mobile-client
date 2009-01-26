//
//  Campaign.h
//  JoeMetric
//
//  Created by Jon Distad on 1/5/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

@interface Campaign : NSObject {
	NSString *_name;
	NSDecimalNumber *_amount;
	NSString *_dbId;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *amount;
@property (nonatomic, retain) NSString *dbId;

- (id)initWithName:(NSString *)name amount:(id)amount dbId:(NSString *)dbId;
- (NSString *)nameAndAmountAsString;
- (NSString *)amountAsDollarString;

@end
