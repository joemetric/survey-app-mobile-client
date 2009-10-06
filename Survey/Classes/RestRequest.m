//
//  RestRequest.m
//  funeral
//
//  Created by Allerin on 09-9-18.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "RestRequest.h"
#import "NSStringExt.h"
#import "JSON.h"
#import "User.h"
#import "NSDictionary+RemoveNulls.h"


static NSString *ServerURL = @"survey.allerin.com";

@implementation RestRequest

+ (NSData *)doPostWithUrl:(NSString *)baseUrl Body:(NSString *)body Error:(NSError **)error returningResponse:(NSURLResponse **)response {
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
	
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	[urlRequest setValue:@"application/x-www-form-urlencoded" 
	  forHTTPHeaderField:@"Content-Type"];
	return [NSURLConnection sendSynchronousRequest:urlRequest 
										   returningResponse:response error:error];
}

+ (void)failedResponse:(NSData *)result Error:(NSError **)error {
	// Check to see if there was an authentication error. If so, report it.
	NSString *outstring = [[NSString alloc] initWithData:result
												 encoding:NSUTF8StringEncoding];
	if (error != NULL) {
		NSObject *errorObj = [outstring JSONFragmentValue];
		NSMutableString *errorString = [NSMutableString string];				
		if ([errorObj isKindOfClass:[NSArray class]]) {
			for (NSArray* error in (NSArray *)errorObj){
				[errorString appendFormat:@"%@ %@\n", [error objectAtIndex:0], [error objectAtIndex:1]];
			}
		}
		NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, nil];
		NSArray *objArray = [NSArray arrayWithObjects:errorString, nil];
		NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
		*error = [[[NSError alloc] initWithDomain:NSURLErrorDomain
											 code:NSURLErrorCancelled userInfo:eDict] autorelease];
	}
	[outstring release];
}

+ (BOOL)loginWithUser:(NSString *)user Password:(NSString *)pass Error:(NSError **)error {
	NSString *body = [NSString stringWithFormat:@"user_session[login]=%@&user_session[password]=%@", [NSString encodeString:user], [NSString encodeString:pass]];
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/user_session.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doPostWithUrl:baseUrl Body:body Error:error returningResponse:&response];
	if (!result) {		
		return FALSE;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			if ([result isKindOfClass:[NSDictionary class]]) {
				NSDictionary *dict = [(NSDictionary *)[[(NSDictionary *)result allValues] objectAtIndex:0] withoutNulls];
				NSString *email = [dict objectForKey:@"email"];
				NSString *login = [dict objectForKey:@"login"];
				NSString *income = [dict objectForKey:@"income"];
				NSString *gender = [dict objectForKey:@"gender"];
				NSString *name = [dict objectForKey:@"name"];
				
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"yyyy-MM-dd"];
				NSString *birth = [dict objectForKey:@"birthdate"];
				NSDate *birthday = nil;
				if (birth)
					birthday = [dateFormatter dateFromString:birth];
				[User saveUserWithEmail:email Login:login Income:income Gender:gender Name:name Password:pass Birthday:birthday];
				[dateFormatter release];
			}
			return TRUE;
		} else {		
			[RestRequest failedResponse:result Error:error];
			return FALSE;
		}
	}		
}

+ (BOOL)signUpWithUser:(NSString *)user Password:(NSString *)pass Email:(NSString *)email 
			 Name:(NSString *)name Error:(NSError **)error {
	NSString *body = [NSString stringWithFormat:@"user[login]=%@&user[email]=%@&user[password]=%@&user[password_confirmation]=%@&user[name]=%@",
											 [NSString encodeString:user], [NSString encodeString:email], [NSString encodeString:pass], [NSString encodeString:pass], [NSString encodeString:name]];
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doPostWithUrl:baseUrl Body:body Error:error returningResponse:&response];

	if (!result) {
		return FALSE;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201)
			return TRUE;
		else {
			[RestRequest failedResponse:result Error:error];		
			return FALSE;
		}
	}		
}

@end
