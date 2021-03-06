//
//  TransferRestRequest.m
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "TransferRestRequest.h"
#import "User.h"
#import "Survey.h"
#import "Transfer.h"
#import "Common.h"
#import "JSON.h"
#import "NSDictionary+RemoveNulls.h"

@implementation RestRequest (TransferOperation)

+ (NSMutableArray *)getPendingTransfers:(User *)user Error:(NSError **)error {
	NSString *baseUrl = [[NSString alloc] initWithFormat:@"http://%@/users/%d/transfers/pending.json", ServerURL, [user.pk intValue]];

	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	[baseUrl release];

	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 200) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			[outstring release];
			NSMutableArray *transfers = [NSMutableArray array];
			for (NSDictionary *dict in (NSArray *)result) {
				NSDictionary *transferDict = [(NSDictionary *)[[dict allValues] objectAtIndex:0] withoutNulls];
				[transfers addObject:[Transfer loadFromJsonDictionary:transferDict]];
			}
			return transfers;
		} else {
			[RestRequest failedResponse:result Error:error];		
			return nil;
		}
	}
}

@end
