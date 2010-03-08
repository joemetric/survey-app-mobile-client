//
//  SurveyRestRequest.h
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestRequest.h"
#import <CoreLocation/CoreLocation.h>

@class Survey, Question,User;

@interface RestRequest (SurveyOperation) <CLLocationManagerDelegate> 
CLLocationManager	*locationManager;

+ (NSMutableArray *)getSurveys:(NSError **)error;
+ (NSMutableArray *)getQuestions:(Survey *)survey Error:(NSError **)error;
+ (BOOL)answerQuestion:(Question *)question Answer:(NSString *)answer Error:(NSError **)error;
+ (BOOL)answerQuestion:(Question *)question Image:(UIImage *)image Error:(NSError **)error;
//+ (BOOL)OrganizationId:(int)org_id SurveyId:(int)sur_id UserId:(int)user_id amount_earned:(float)amount_earned Error:(NSError **)error;
+ (BOOL)OrganizationId:(int)org_id SurveyId:(int)sur_id UserId:(int)user_id amount_earned:(float)amount_earned amount_donated_by_user:(float)amount_donated_by_user Error:(NSError **)error; 

+ (void)locationSpecificSurveyInformation;
@end
