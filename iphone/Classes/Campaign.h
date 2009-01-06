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
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDecimalNumber *amount;

@end
