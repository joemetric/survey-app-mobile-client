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
    NSInteger pictureId;
    NSString *questionType;
    NSString *answerString;
    NSString *answerFile;
    NSString *localImageFile;
}

@property (nonatomic) NSInteger itemId;
@property (nonatomic) NSInteger questionId;
@property (nonatomic) NSInteger pictureId;
@property (nonatomic, retain) NSString *questionType;
@property (nonatomic, retain) NSString *answerString;
@property (nonatomic, retain) NSString *answerFile;
@property (nonatomic, retain) NSString *localImageFile;

+ (id)newFromDictionary:(NSDictionary *)dict;

- (NSDictionary *)toDictionary;
- (BOOL)store;
@end
