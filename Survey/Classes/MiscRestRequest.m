//
//  MiscRestRequest.m
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "MiscRestRequest.h"
#import "KVPair.h"
#import "Common.h"
#import "JSON.h"


@implementation RestRequest (MiscOperation)

#pragma mark -
#pragma mark Common Request

+ (NSMutableArray *)getKVPairArray:(NSString *)baseUrl Error:(NSError **)error {
	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	
	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 200) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			[outstring release];
			NSMutableArray *pairs = [NSMutableArray array];
			for (NSArray *res in (NSArray *)result) {
				NSNumber *pk = [res objectAtIndex:0];
				NSString *desc = [res objectAtIndex:1];
				KVPair *pair = [[KVPair alloc] initWithPk:pk Desc:desc];
				[pairs addObject:pair];
				[pair release];
			}
			return pairs;
		} else {
			[RestRequest failedResponse:result Error:error];		
			return nil;
		}
	}		
}

+ (NSMutableArray *)getKVArray:(NSString *)key Error:(NSError **)error {
	NSString *baseUrl = [[NSString alloc] initWithFormat:@"http://%@/users/%@.json", ServerURL, key];
	NSMutableArray *results = [self getKVPairArray:baseUrl Error:error];
	[baseUrl release];
	return results;
}

+ (NSMutableArray *)getIncomeArray:(NSError **)error {
	return [self getKVArray:@"incomes" Error:error];
}

+ (NSMutableArray *)getRaceArray:(NSError **)error {
	return [self getKVArray:@"races" Error:error];
}

+ (NSMutableArray *)getMartialArray:(NSError **)error {
	return [self getKVArray:@"martial_statuses" Error:error];
}

+ (NSMutableArray *)getEducationArray:(NSError **)error {
	return [self getKVArray:@"educations" Error:error];
}

+ (NSMutableArray *)getOccupationArray:(NSError **)error {
	return [self getKVArray:@"occupations" Error:error];
}

+ (NSMutableArray *)getSortArray:(NSError **)error {
	return [self getKVArray:@"sorts" Error:error];
}

@end
