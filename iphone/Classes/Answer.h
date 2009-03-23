//
//  Answer.h
//  JoeMetric
//
//  Created by Scott Barron on 3/10/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "Resource.h"


@interface Answer : Resource {
    NSInteger questionId;
    NSString *questionType;
}

@property (nonatomic) NSInteger questionId;
@property (nonatomic, retain) NSString *questionType;

@end
