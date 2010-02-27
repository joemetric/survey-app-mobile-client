//
//  UserRestRequest.m
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "UserRestRequest.h"
#import "User.h"
#import "NSStringExt.h"
#import "NSDictionary+RemoveNulls.h"
#import "JSON.h"
#import "Common.h"


@implementation RestRequest (UserOperation)

+ (BOOL)loginWithUser:(NSString *)user Password:(NSString *)pass Error:(NSError **)error {
	NSBundle* mainBundle = [NSBundle mainBundle];
	NSNumber *version = [mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"];
	UIDevice *device = [UIDevice currentDevice];
	NSString *body = [[NSString alloc] initWithFormat:@"user_session[login]=%@&user_session[password]=%@&client_version=%.1f&device_id=%@", 
					  [NSString encodeString:user], [NSString encodeString:pass], [version floatValue], [device uniqueIdentifier]];
	NSString *baseUrl = [[NSString alloc] initWithFormat:@"http://%@/user_session.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doPostWithUrl:baseUrl Body:body Error:error returningResponse:&response];
		[body release];
	[baseUrl release];
	
	if (!result) {		
		return FALSE;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			[outstring release];
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
				NSNumber *race_id = [dict objectForKey:@"race_id"];
				NSString *race = [dict objectForKey:@"race"];
				NSNumber *martial_id = [dict objectForKey:@"martial_status_id"];
				NSString *martial = [dict objectForKey:@"martial_status"];
				NSNumber *education_id = [dict objectForKey:@"education_id"];
				NSString *education = [dict objectForKey:@"education"];
				NSNumber *occupation_id = [dict objectForKey:@"occupation_id"];
				NSString *occupation = [dict objectForKey:@"occupation"];
				NSNumber *sort_id = [dict objectForKey:@"sort_id"];
				NSString *sort = [dict objectForKey:@"sort"];
				NSString *warning = [dict objectForKey:@"warn_preference"];
				
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"yyyy-MM-dd"];
				NSString *birth = [dict objectForKey:@"birthdate"];
				NSDate *birthday = nil;
				if (birth)
					birthday = [dateFormatter dateFromString:birth];
				[User saveUserWithPK:pk Email:email Login:login Income_id:income_id Income:income Gender:gender 
								Name:name Password:pass Birthday:birthday Zipcode:zipcode Race_id:race_id
						  Martial_id:martial_id Race:race	Martial:martial Education_id:education_id
						   Education:education Occupation_id:occupation_id Occupation:occupation
							 Sort_id:sort_id Sort:sort];
				if (warning && ![warning isEqualToString:@""]) {
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
																	message:warning
																   delegate:self
														  cancelButtonTitle:@"OK"
														  otherButtonTitles:nil];
					[alert show];
					[alert release];
				}
				[dateFormatter release];
			}
			
			// If you want to get all of the cookies:
//			NSString *urlHost = [[NSString alloc] initWithFormat:@"http://%@", ServerURL];
//			NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)response allHeaderFields] forURL:[NSURL URLWithString:urlHost]];
//			[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:all forURL:[NSURL URLWithString:urlHost] mainDocumentURL:nil];
//			[urlHost release];
			
			return TRUE;
		} else {
			[RestRequest failedResponse:result Error:error];
			return FALSE;
		}
	}
}

+ (BOOL)signUpWithUser:(NSString *)user Password:(NSString *)pass Email:(NSString *)email 
				  Name:(NSString *)name Error:(NSError **)error {
	NSString *body = [[NSString alloc] initWithFormat:@"user[login]=%@&user[email]=%@&user[password]=%@&user[password_confirmation]=%@&user[name]=%@",
					  [NSString encodeString:user], [NSString encodeString:email], [NSString encodeString:pass], [NSString encodeString:pass], [NSString encodeString:name]];
	NSString *baseUrl = [[NSString alloc] initWithFormat:@"http://%@/users.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doPostWithUrl:baseUrl Body:body Error:error returningResponse:&response];
	[body release];
	[baseUrl release];
	
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
	NSMutableString *body = [[NSMutableString alloc] init];
	if (user.birthday)
		[body appendFormat:@"user[birthdate]=%@&", [NSString encodeString:[user birthdate]]];
	if (user.gender)
		[body appendFormat:@"user[gender]=%@&", [NSString encodeString:user.gender]];
	if (user.income_id)
		[body appendFormat:@"user[income_id]=%d&", [user.income_id intValue]];
	if (user.zipcode)
		[body appendFormat:@"user[zip_code]=%@&", [NSString encodeString:user.zipcode]];
	if (user.race_id)
		[body appendFormat:@"user[race_id]=%d&", [user.race_id intValue]];
	if (user.martial_id)
		[body appendFormat:@"user[martial_status_id]=%d&", [user.martial_id intValue]];
	if (user.education_id)
		[body appendFormat:@"user[education_id]=%d&", [user.education_id intValue]];
	if (user.occupation_id)
		[body appendFormat:@"user[occupation_id]=%d&", [user.occupation_id intValue]];
	if (user.sort_id)
		[body appendFormat:@"user[sort_id]=%d&", [user.sort_id intValue]];
	NSString *baseUrl = [[NSString alloc] initWithFormat:@"http://%@/users/%d.json", ServerURL, [user.pk intValue]];
	NSURLResponse *response;
	NSData *result = [RestRequest doPutWithUrl:baseUrl Body:body Error:error returningResponse:&response];
	[body release];
	[baseUrl release];
	
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
