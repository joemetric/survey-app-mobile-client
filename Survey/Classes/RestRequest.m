//
//  RestRequest.m
//  funeral
//
//  Created by Allerin on 09-9-18.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "RestRequest.h"
#import "NSStringExt.h"
#import "NSDictionary+RemoveNulls.h"
#import "JSON.h"
#import "Common.h"

@implementation RestRequest

+ (NSData *)requestWithUrl:(NSString *)baseUrl Method:(NSString *)method Body:(NSString *)body
					 Error:(NSError **)error returningResponse:(NSURLResponse **)response {
	NSURL *url = [NSURL URLWithString:baseUrl];
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
	if (!urlRequest)
	{
		if (error != NULL) {
			NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, nil];
			NSArray *objArray = [NSArray arrayWithObjects:@"Error creating URL Request.", nil];
			NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
			*error = [[[NSError alloc] initWithDomain:NSURLErrorDomain
												 code:NSURLErrorCannotFindHost userInfo:eDict] autorelease];
		}
		return FALSE;
	}
	
//	NSString *urlHost = [[NSString alloc] initWithFormat:@"http://%@", ServerURL];
//	NSArray * availableCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:urlHost]];
//	NSDictionary * headers = [NSHTTPCookie requestHeaderFieldsWithCookies:availableCookies];
//	[urlRequest setAllHTTPHeaderFields:headers];
//	[urlHost release];
	
	[urlRequest setHTTPMethod:method];
	if (body) {
		[urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
		[urlRequest setValue:@"application/x-www-form-urlencoded" 
		  forHTTPHeaderField:@"Content-Type"];
		[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	}
	return [NSURLConnection sendSynchronousRequest:urlRequest 
								 returningResponse:response error:error];	
}

+ (NSData *)doGetWithUrl:(NSString *)baseUrl Error:(NSError **)error returningResponse:(NSURLResponse **)response {
	return [RestRequest requestWithUrl:baseUrl Method:@"GET" Body:nil Error:error returningResponse:response];
}

+ (NSData *)doPostWithUrl:(NSString *)baseUrl Body:(NSString *)body Error:(NSError **)error returningResponse:(NSURLResponse **)response {
	return [RestRequest requestWithUrl:baseUrl Method:@"POST" Body:body Error:error returningResponse:response];
}

+ (NSData *)doPutWithUrl:(NSString *)baseUrl Body:(NSString *)body Error:(NSError **)error returningResponse:(NSURLResponse **)response {
	return [RestRequest requestWithUrl:baseUrl Method:@"PUT" Body:body Error:error returningResponse:response];
}

+ (NSData *)failedResponse:(NSData *)result Error:(NSError **)error {
	if (error == NULL) 
		return nil;
	
	// Check to see if there was an authentication error. If so, report it.
	NSString *outstring = [[NSString alloc] initWithData:result
												encoding:NSUTF8StringEncoding];
	NSObject *errorObj = [outstring JSONFragmentValue];
	NSMutableString *errorString = [NSMutableString string];				
	if ([errorObj isKindOfClass:[NSArray class]]) {
		for (NSArray* error in (NSArray *)errorObj){
			if ([[error objectAtIndex:0] isEqualToString:@"base"]) {
				[errorString appendFormat:@"%@\n", [error objectAtIndex:1]];
			} else {
				[errorString appendFormat:@"%@ %@\n", [error objectAtIndex:0], [error objectAtIndex:1]];
			}
		}
	} else {
		[errorString appendString:@"To have no errors\nWould be life without meaning\nNo struggle, no joy"];
	}
	NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, nil];
	NSArray *objArray = [NSArray arrayWithObjects:errorString, nil];
	NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
	*error = [[[NSError alloc] initWithDomain:NSURLErrorDomain
										 code:NSURLErrorCancelled userInfo:eDict] autorelease];
	[outstring release];
	return result;
}

@end
