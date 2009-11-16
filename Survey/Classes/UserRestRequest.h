//
//  UserRestRequest.h
//  Survey
//
//  Created by Ye Dingding on 09-11-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestRequest.h"

@class User;

@interface RestRequest (UserOperation)

+ (BOOL)loginWithUser:(NSString *)user Password:(NSString *)pass Error:(NSError **)error;
+ (BOOL)signUpWithUser:(NSString *)user Password:(NSString *)pass Email:(NSString *)email Name:(NSString *)name Error:(NSError **)error;
+ (BOOL)saveWithUser:(User *)user Error:(NSError **)error;

@end
