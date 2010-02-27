//
//  SurveyRestRequest.h
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestRequest.h"

@class Survey, Question;

@interface RestRequest (SurveyOperation)

+ (NSMutableArray *)getSurveys:(NSError **)error;
+ (NSMutableArray *)getQuestions:(Survey *)survey Error:(NSError **)error;
+ (BOOL)answerQuestion:(Question *)question Answer:(NSString *)answer Error:(NSError **)error;
+ (BOOL)answerQuestion:(Question *)question Image:(UIImage *)image Error:(NSError **)error;
+ (BOOL)OrganizationId:(int)org_id SurveyId:(int)sur_id UserId:(int)user_id amount_earned:(NSString*)amount_earned Error:(NSError **)error;

@end
