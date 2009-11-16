//
//  Transfer.h
//  Survey
//
//  Created by Ye Dingding on 09-11-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Survey.h"

@interface Transfer : NSObject {
	NSInteger pk;
	NSDate *created_at;
	NSNumber *amount;
	NSString *status;
	Survey *survey;
}

@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, retain) NSDate *created_at;
@property (nonatomic, retain) NSNumber *amount;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) Survey *survey;

+ (Transfer *)loadFromJsonDictionary:(NSDictionary *)transferDict;
- (id)initWithPk:(NSInteger)p CreatedAt:(NSDate *)ca Amount:(NSNumber *)amt Status:(NSString *)stat Survey:(Survey *)suv;

- (NSDate *)approvalDate;

@end
