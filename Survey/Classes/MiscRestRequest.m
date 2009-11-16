//
//  MiscRestRequest.m
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "MiscRestRequest.h"
#import "Income.h"
#import "Common.h"
#import "JSON.h"


@implementation RestRequest (MiscOperation)

#pragma mark -
#pragma mark Common Request

+ (NSMutableArray *)getIncomeArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/incomes.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	
	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			NSMutableArray *incomes = [NSMutableArray array];
			for (NSArray *income in (NSArray *)result) {
				NSNumber *pk = [income objectAtIndex:0];
				NSString *desc = [income objectAtIndex:1];
				Income *income = [[Income alloc] initWithPk:pk Desc:desc];
				[incomes addObject:income];
				[income release];
			}
			return incomes;
		} else {
			[RestRequest failedResponse:result Error:error];		
			return nil;
		}
	}	
}

@end
