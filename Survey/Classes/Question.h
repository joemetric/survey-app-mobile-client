//
//  Question.h
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Survey;

@interface Question : NSObject {
	Survey *survey;
	NSInteger pk;
	NSInteger question_type_id;
	NSString *name;
}

@property (nonatomic, retain) Survey *survey;
@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, assign) NSInteger question_type_id;
@property (nonatomic, retain) NSString *name;

- (id)initWithSurvey:(Survey *)s PK:(NSInteger)p QuestionTypeId:(NSInteger)qti Name:(NSString *)n;

@end
