//
//  Answer.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Answer : NSObject {
	NSNumber *pk;
	NSNumber *question_id;
	NSString *answer;
}

@property (nonatomic, retain) NSNumber *pk;
@property (nonatomic, retain) NSNumber *quesiton_id;
@property (nonatomic, retain) NSString *answer;

@end
