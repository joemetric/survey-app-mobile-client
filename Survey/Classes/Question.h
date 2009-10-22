//
//  Question.h
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Survey, Answer;

typedef enum {
	UNKNOWN = 0,
	ShortAnswer = 1,
	MultipleChoice,
	PhotoUpload
} QuestionType ;

@interface Question : NSObject {
	Survey *survey;
	NSInteger pk;
	QuestionType question_type;
	NSString *name;
	NSString *description;
	NSArray *complement;
	Answer *answer;
	UIImage *image;
}

@property (nonatomic, retain) Survey *survey;
@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, assign) QuestionType question_type;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSArray *complement;
@property (nonatomic, retain) Answer *answer;
@property (nonatomic, retain) UIImage *image;

- (id)initWithSurvey:(Survey *)s PK:(NSInteger)p QuestionType:(NSString *)qt Name:(NSString *)n Description:(NSString *)desc;
- (BOOL)isShortAnswer;
- (BOOL)isMultipleChoice;
- (BOOL)isPhotoUpload;

@end
