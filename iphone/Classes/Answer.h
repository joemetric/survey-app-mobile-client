//
//  Answer.h
//  JoeMetric
//
//  Created by Scott Barron on 3/10/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

@interface Answer : NSObject {
    NSInteger itemId;
    NSInteger questionId;
    NSString *questionType;
    NSString *answerString;
    NSString *answerFile;
}

@property (nonatomic) NSInteger itemId;
@property (nonatomic) NSInteger questionId;
@property (nonatomic, retain) NSString *questionType;
@property (nonatomic, retain) NSString *answerString;
@property (nonatomic, retain) NSString *answerFile;

+ (id)newFromDictionary:(NSDictionary *)dict;

- (BOOL)store;
@end
