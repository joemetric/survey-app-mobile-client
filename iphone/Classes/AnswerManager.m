//
//  AnswerManager.m
//  JoeMetric
//
//  Created by Scott Barron on 4/8/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "AnswerManager.h"
#import "Answer.h"
#import "RestConfiguration.h"

@interface AnswerManager (Private)
- (void)push;
- (void)pushBasicAnswer;
- (void)pushPictureAnswer;
@end

@implementation AnswerManager

@synthesize answer;

+ (void)pushAnswer:(Answer *)answer {
    NSLog(@"Pushing answer to server %@", answer.questionType);
    AnswerManager *manager = [[AnswerManager alloc] initWithAnswer:answer];
    [manager push];
    [manager release];
}

- (void)push {
    if ([answer.questionType isEqualToString:@"picture"]) {
        [self pushPictureAnswer];
    } else {
        [self pushBasicAnswer];
    }
}

- (void)pictureUploaded:(NSString *)data {
    answer.pictureId = [data integerValue];
    NSLog(@"Picture has been uploaded: %@", data);
    [self pushBasicAnswer];
}

- (void)pushPictureAnswer {
    NSLog(@"Pushing picture");
    PictureUploader *uploader = [[PictureUploader alloc] initWithImage:answer.localImageFile andObserver:self];
    [uploader upload];
}

- (void)pushBasicAnswer {
    // push answer to server
    NSLog(@"Pushing basics");
    [[RestfulRequests restfulRequestsWithObserver:self] POST:@"/answers.json" withParams:[answer toDictionary]];
}

-(void) authenticationFailed {
    
}

-(void) failedWithError:(NSError *)error {
    
}

-(void) finishedLoading:(NSString *)data {
}

- (id)initWithAnswer:(Answer *)anAnswer {
    if (self = [super init]) {
        self.answer = anAnswer;
    }
    return self;
}
@end
