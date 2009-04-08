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

- (void)pushPictureAnswer {
    // upload picture
    [self pushBasicAnswer];
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
        host   = [RestConfiguration host];
        port   = [RestConfiguration port];
        buffer = [[NSMutableData alloc] init];
        
        NSMutableDictionary *headers = [[[NSMutableDictionary alloc] init] autorelease];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:@"text/json" forKey:@"Accept"];
        [headers setValue:@"no-cache" forKey:@"Cache-Control"];
        [headers setValue:@"no-cache" forKey:@"Pragma"];
        [headers setValue:@"close" forKey:@"Connection"];
        
        request = [NSMutableURLRequest requestWithURL:nil
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                      timeoutInterval:60.0];
        
        [request setAllHTTPHeaderFields:headers];
    }
    return self;
}
@end
