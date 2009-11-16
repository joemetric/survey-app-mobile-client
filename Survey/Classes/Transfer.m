//
//  Transfer.m
//  Survey
//
//  Created by Ye Dingding on 09-11-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Transfer.h"
#import "NSDictionary+RemoveNulls.h"


@implementation Transfer
@synthesize pk, created_at, amount, status, survey;


+ (Transfer *)loadFromJsonDictionary:(NSDictionary *)transferDict {
	NSInteger pk = [[transferDict objectForKey:@"id"] intValue];
	NSNumber *amount = [transferDict objectForKey:@"amount"];
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	NSDate *created_at = [df dateFromString:[transferDict objectForKey:@"created_at"]];
	[df release];
	NSString *status = [transferDict objectForKey:@"status"];
	NSDictionary *surveyDict = [[[[transferDict objectForKey:@"survey"] allValues] objectAtIndex:0] withoutNulls];
	
	Transfer *transfer = [[Transfer alloc] initWithPk:pk CreatedAt:created_at Amount:amount Status:status Survey:[Survey loadFromJsonDictionary:surveyDict]];
	return [transfer autorelease];
}

- (id)initWithPk:(NSInteger)p CreatedAt:(NSDate *)ca Amount:(NSNumber *)amt Status:(NSString *)stat Survey:(Survey *)suv {
	if (self = [super init]) {
		self.pk = p;
		self.created_at = ca;
		self.amount = amt;
		self.status = stat;
		self.survey = suv;
	}
	return self;				  
}

- (void) dealloc
{
	[created_at release];
	[amount release];
	[status release];
	[survey release];
	
	[super dealloc];
}

- (NSDate *)approvalDate {
	return [created_at addTimeInterval:604800];
}


@end
