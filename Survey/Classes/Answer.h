//
//  Answer.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface Answer : NSObject {
	NSInteger pk;
	Question *question;
	NSString *answer;
}

@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) NSString *answer;

- (id)initWithPK:(NSInteger)p Question:(Question *)ques Answer:(NSString *)ans;

@end
