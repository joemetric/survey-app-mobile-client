//
//  Answer.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Answer : NSObject {
	NSInteger pk;
	NSInteger question_id;
	NSString *answer;
}

@property (nonatomic, assign) NSInteger pk;
@property (nonatomic, assign) NSInteger question_id;
@property (nonatomic, retain) NSString *answer;

@end
