//
//  RestRequest.h
//  funeral
//
//  Created by Allerin on 09-9-18.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Survey, User;

@interface RestRequest : NSObject {

}

+ (BOOL)loginWithUser:(NSString *)user Password:(NSString *)pass Error:(NSError **)error;
+ (BOOL)signUpWithUser:(NSString *)user Password:(NSString *)pass Email:(NSString *)email Name:(NSString *)name Error:(NSError **)error;
+ (BOOL)saveWithUser:(User *)user Error:(NSError **)error;


+ (NSMutableArray *)getSurveys:(NSError **)error;
+ (NSMutableArray *)getQuestions:(Survey *)survey Error:(NSError **)error;

@end
