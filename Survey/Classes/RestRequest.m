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
#import "User.h"
#import "Survey.h"
#import "Question.h"


static NSString *ServerURL = @"localhost:3000";

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

#pragma mark -
#pragma mark User Request

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
				NSString *income = [dict objectForKey:@"income"];
				NSString *gender = [dict objectForKey:@"gender"];
				NSString *name = [dict objectForKey:@"name"];
				
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"yyyy-MM-dd"];
				NSString *birth = [dict objectForKey:@"birthdate"];
				NSDate *birthday = nil;
				if (birth)
					birthday = [dateFormatter dateFromString:birth];
				[User saveUserWithPK:pk Email:email Login:login Income:income Gender:gender Name:name Password:pass Birthday:birthday];
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
	if (user.income)
		[body appendFormat:@"user[income]=%d&", [user.income intValue]];
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


#pragma mark -
#pragma mark Survey Request

+ (NSMutableArray *)getSurveys:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/surveys.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	
	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			NSMutableArray *surveys = [NSMutableArray array];
			for (NSDictionary *dict in (NSArray *)result) {
				NSDictionary *surveyDict = [(NSDictionary *)[[dict allValues] objectAtIndex:0] withoutNulls];
				NSInteger pk = [[surveyDict objectForKey:@"id"] intValue];
				NSString *name = [surveyDict objectForKey:@"name"];
				NSString *desc = [surveyDict objectForKey:@"description"];
				Survey *survey = [[Survey alloc] initWithPk:pk Name:name Description:desc];
				[surveys addObject:survey];
				[survey release];
			}
			return surveys;
		} else {
			[RestRequest failedResponse:result Error:error];		
			return nil;
		}
	}
}

+ (NSMutableArray *)getQuestions:(Survey *)survey Error:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/surveys/%d/questions.json", ServerURL, survey.pk];
	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			NSMutableArray *questions = [NSMutableArray array];
			for (NSDictionary *dict in (NSArray *)result) {
				NSDictionary *questionDict = [(NSDictionary *)[[dict allValues] objectAtIndex:0] withoutNulls];
				NSInteger pk = [[questionDict objectForKey:@"id"] intValue];
				NSInteger question_type_id = [[questionDict objectForKey:@"question_type_id"] intValue];
				NSString *name = [questionDict objectForKey:@"name"];
				NSString *description = [questionDict objectForKey:@"complement"];
				Question *question = [[Question alloc] initWithSurvey:survey PK:pk QuestionTypeId:question_type_id Name:name Description:description];
				[questions addObject:question];
				[question release];
			}
			return questions;
		} else {
			[RestRequest failedResponse:result Error:error];		
			return nil;
		}
	}
}

@end
