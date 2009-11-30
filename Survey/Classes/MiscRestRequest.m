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
			for (NSArray *res in (NSArray *)result) {
				NSNumber *pk = [res objectAtIndex:0];
				NSString *desc = [res objectAtIndex:1];
				KVPair *income = [[KVPair alloc] initWithPk:pk Desc:desc];
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

+ (NSMutableArray *)getRaceArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/races.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	
	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			NSMutableArray *races = [NSMutableArray array];
			for (NSArray *res in (NSArray *)result) {
				NSNumber *pk = [res objectAtIndex:0];
				NSString *desc = [res objectAtIndex:1];
				KVPair *race = [[KVPair alloc] initWithPk:pk Desc:desc];
				[races addObject:race];
				[race release];
			}
			return races;
		} else {
			[RestRequest failedResponse:result Error:error];		
			return nil;
		}
	}
}

+ (NSMutableArray *)getMartialArray:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/martial_statuses.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	
	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			NSMutableArray *martials = [NSMutableArray array];
			for (NSArray *res in (NSArray *)result) {
				NSNumber *pk = [res objectAtIndex:0];
				NSString *desc = [res objectAtIndex:1];
				KVPair *martial = [[KVPair alloc] initWithPk:pk Desc:desc];
				[martials addObject:martial];
				[martial release];
			}
			return martials;
		} else {
			[RestRequest failedResponse:result Error:error];		
			return nil;
		}
	}
}

@end
