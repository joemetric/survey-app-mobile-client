//
//  AnswerManager.h
//  JoeMetric
//
//  Created by Scott Barron on 4/8/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestfulRequests.h"

@class Answer;

@interface AnswerManager : NSObject <RestfulRequestsObserver> {
    Answer *answer;
    NSString      *host;
    NSInteger      port;
    NSMutableData *buffer;
    NSMutableURLRequest *request;
    NSURLConnection *conn;
}

@property (nonatomic, retain) Answer *answer;

+ (void)pushAnswer:(Answer *)answer;

- (id)initWithAnswer:(Answer *)answer;

@end
