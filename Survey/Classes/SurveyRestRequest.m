//
//  SurveyRestRequest.m
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "SurveyRestRequest.h"
#import "Survey.h"
#import "Question.h"
#import "Answer.h"
#import "Common.h"
#import "JSON.h"
#import "NSDictionary+RemoveNulls.h"


@implementation RestRequest (SurveyOperation)

+ (NSMutableArray *)getSurveys:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/surveys.json", ServerURL];
	NSURLResponse *response;
	NSData *result = [RestRequest doGetWithUrl:baseUrl Error:error returningResponse:&response];
	
	if (!result) {
		return nil;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 200) {
			NSString *outstring = [[NSString alloc] initWithData:result
														encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			NSMutableArray *surveys = [NSMutableArray array];
			for (NSDictionary *dict in (NSArray *)result) {
				NSDictionary *surveyDict = [(NSDictionary *)[[dict allValues] objectAtIndex:0] withoutNulls];
				[surveys addObject:[Survey loadFromJsonDictionary:surveyDict]];
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
				NSString *question_type = [questionDict objectForKey:@"question_type_name"];
				NSString *name = [questionDict objectForKey:@"name"];
				NSString *description = [questionDict objectForKey:@"description"];
				Question *question = [[Question alloc] initWithSurvey:survey PK:pk QuestionType:question_type Name:name Description:description];
				NSObject *complement = [questionDict objectForKey:@"complement"];
				if (![complement isKindOfClass:[NSNull class]] && [complement isKindOfClass:[NSMutableArray class]]) {
					[question setComplement:(NSArray *)complement];
				}
				NSObject *answer = [questionDict objectForKey:@"answer_by_user"];
				if (![answer isKindOfClass:[NSNull class]] && [answer isKindOfClass:[NSMutableDictionary class]]) {
					NSDictionary *answerDict = (NSDictionary *)[(NSDictionary *)answer objectForKey:@"answer"];
					NSInteger apk = [[answerDict objectForKey:@"id"] intValue];
					NSString *text = [answerDict objectForKey:@"answer"];
					Answer *answer = [[Answer alloc] initWithPK:apk Question:question Answer:text];
					[question setAnswer:answer];
					[answer release];
				}
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

+ (BOOL)answerQuestion:(Question *)question Answer:(NSString *)answer Error:(NSError **)error {
	NSString *body = [NSString stringWithFormat:@"answer[answer]=%@", answer];
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/questions/%d/answers", ServerURL, question.pk];
	NSURLResponse *response;
	NSData *result = [RestRequest doPostWithUrl:baseUrl Body:body Error:error returningResponse:&response];
	
	if (!result) {
		return FALSE;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result	encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			if ([result isKindOfClass:[NSDictionary class]]) {
				NSDictionary *dict = [(NSDictionary *)[[(NSDictionary *)result allValues] objectAtIndex:0] withoutNulls];
				NSInteger pk = [[dict objectForKey:@"id"] intValue];
				NSString *text = [dict objectForKey:@"answer"];
				Answer *answer = [[Answer alloc] initWithPK:pk Question:question Answer:text];
				[question setAnswer:answer];
				[answer release];
			}
			
			return TRUE;
		} else {
			[RestRequest failedResponse:result Error:error];
			return FALSE;
		}
	}
}

+ (BOOL)answerQuestion:(Question *)question Image:(UIImage *)image Error:(NSError **)error {
	NSString *baseUrl = [NSString stringWithFormat:@"http://%@/questions/%d/answers", ServerURL, question.pk];
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
	NSData *postData = generatePostDataForData(UIImagePNGRepresentation(image));
	if (postData) {
		NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
		[urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[urlRequest setValue:@"multipart/form-data; boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
		[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		[urlRequest setHTTPBody:postData];
	}
	NSURLResponse *response;
	NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest 
										   returningResponse:&response error:error];
	if (!result) {
		return FALSE;
	} else {
		if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 201) {
			NSString *outstring = [[NSString alloc] initWithData:result	encoding:NSUTF8StringEncoding];
			NSObject *result = [outstring JSONFragmentValue];
			if ([result isKindOfClass:[NSDictionary class]]) {
				NSDictionary *dict = [(NSDictionary *)[[(NSDictionary *)result allValues] objectAtIndex:0] withoutNulls];
				NSInteger pk = [[dict objectForKey:@"id"] intValue];
				NSString *text = [dict objectForKey:@"answer"];
				Answer *answer = [[Answer alloc] initWithPK:pk Question:question Answer:text];
				[question setAnswer:answer];
				[answer release];
			}
			
			return TRUE;
		} else {
			[RestRequest failedResponse:result Error:error];
			return FALSE;
		}
	}	
}

@end
