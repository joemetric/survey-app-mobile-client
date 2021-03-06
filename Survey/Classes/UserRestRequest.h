//
//  UserRestRequest.h
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestRequest.h"

@class User;
@class SettingsController;
@interface RestRequest (UserOperation)
BOOL locationSurveyOn;

SettingsController *settingsController;

+ (BOOL)loginWithUser:(NSString *)user Password:(NSString *)pass Error:(NSError **)error;
+ (BOOL)signUpWithUser:(NSString *)user Password:(NSString *)pass Email:(NSString *)email Name:(NSString *)name Error:(NSError **)error;
+ (BOOL)saveWithUser:(User *)user Error:(NSError **)error;
+ (BOOL)saveWithUser:(User *)user get_geographical_location_targeted_surveys:(BOOL)get_geographical_location_targeted_surveys  Error:(NSError **)error;

@end
//@property(nonatomic, retain) SettingsController *settingsController;
