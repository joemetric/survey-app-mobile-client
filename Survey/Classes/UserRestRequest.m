//
//  UserRestRequest.m
//  Survey
//
//  Created by Ye Dingding on 09-11-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UserRestRequest.h"
#import "User.h"
#import "NSStringExt.h"
#import "NSDictionary+RemoveNulls.h"
#import "JSON.h"
#import "Common.h"


@implementation RestRequest (UserOperation)

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
				NSNumber *pk = [dict objectForKey:@"id"];
				NSString *email = [dict objectForKey:@"email"];
				NSString *login = [dict objectForKey:@"login"];
				NSNumber *income_id = [dict objectForKey:@"income_id"];
				NSString *income = [dict objectForKey:@"income"];
				NSString *gender = [dict objectForKey:@"gender"];
				NSString *name = [dict objectForKey:@"name"];
				NSString *zipcode = [dict objectForKey:@"zip_code"];
				
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"yyyy-MM-dd"];
				NSString *birth = [dict objectForKey:@"birthdate"];
				NSDate *birthday = nil;
				if (birth)
					birthday = [dateFormatter dateFromString:birth];
				[User saveUserWithPK:pk Email:email Login:login Income_id:income_id Income:income Gender:gender Name:name Password:pass Birthday:birthday Zipcode:zipcode];
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

+ (BOOL)saveWithUser:(User *)user Error:(NSError **)error {
	NSMutableString *body = [NSMutableString string];
	if (user.birthday)
		[body appendFormat:@"user[birthdate]=%@&", [NSString encodeString:[user birthdate]]];
	if (user.gender)
		[body appendFormat:@"user[gender]=%@&", [NSString encodeString:user.gender]];
	if (user.income_id)
		[body appendFormat:@"user[income_id]=%d&", [user.income_id intValue]];
	if (user.zipcode)
		[body appendFormat:@"user[zip_code]=%@&", [NSString encodeString:user.zipcode]];
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/users/%d.json", ServerURL, [user.pk intValue]];
	NSURLResponse *response;
	NSData *result = [RestRequest doPutWithUrl:baseUrl Body:body Error:error returningResponse:&response];
	if (!result) {
		return FALSE;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 202)
			return TRUE;
		else {
			[RestRequest failedResponse:result Error:error];		
			return FALSE;
		}		
	}
}

@end
