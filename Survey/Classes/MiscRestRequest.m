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

+ (NSMutableArray *)getIncomeArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/incomes.json", ServerURL];
	return [self getKVPairArray:baseUrl Error:error];
}

+ (NSMutableArray *)getRaceArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/races.json", ServerURL];
	return [self getKVPairArray:baseUrl Error:error];
}

+ (NSMutableArray *)getMartialArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/martial_statuses.json", ServerURL];
	return [self getKVPairArray:baseUrl Error:error];
}

+ (NSMutableArray *)getEducationArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/educations.json", ServerURL];
	return [self getKVPairArray:baseUrl Error:error];
}

+ (NSMutableArray *)getOccupationArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/occupations.json", ServerURL];
	return [self getKVPairArray:baseUrl Error:error];
}

+ (NSMutableArray *)getSortArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/sorts.json", ServerURL];
	return [self getKVPairArray:baseUrl Error:error];
}

@end
