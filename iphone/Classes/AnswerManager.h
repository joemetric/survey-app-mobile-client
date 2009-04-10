//
//  AnswerManager.h
//  JoeMetric
//
//  Created by Scott Barron on 4/8/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestfulRequests.h"
#import "PictureUploader.h"

@class Answer;

@interface AnswerManager : NSObject <RestfulRequestsObserver, PictureUploaderObserver> {
    Answer *answer;
}

@property (nonatomic, retain) Answer *answer;

+ (void)pushAnswer:(Answer *)answer;

- (id)initWithAnswer:(Answer *)answer;

@end
